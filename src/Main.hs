{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Control.Monad.IO.Class
import Data.Aeson
import Data.IORef
import Data.Proxy
import GHC.Generics
import Servant
import Servant.JS
import Servant.JS.JQuery
import System.Environment ( getArgs )
import Network.Wai.Handler.Warp ( run )

main :: IO ()
main = do
  [cmd, out] <- getArgs
  case cmd of
    "client" -> do
      let def = defCommonGeneratorOptions
      writeJSForAPI api (jqueryWith (def { urlPrefix = "/api" })) out
    "server" -> do
      statusVar <- newIORef (Status { status = False})
      run 8086 (serve api (server statusVar))
    _ -> do
      putStrLn "unknown command!"

server :: IORef Status -> Server API
server statusVar = postStatus :<|> getStatus where
  postStatus :: Status -> Handler ()
  postStatus s = liftIO $ writeIORef statusVar s

  getStatus :: Handler Status
  getStatus = liftIO $ readIORef statusVar

type API
  = "status" :> (
    ReqBody '[JSON] Status :> Post '[JSON] ()
    :<|>
    Get '[JSON] Status
  )

data Status
  = Status
    { status :: Bool
    }
  deriving (Generic, FromJSON, ToJSON)

api :: Proxy API
api = Proxy
