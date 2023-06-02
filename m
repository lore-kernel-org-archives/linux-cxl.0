Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFDDC7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 21:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjFBViT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBViT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 17:38:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A39A3
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 14:38:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bacf685150cso2741352276.3
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jun 2023 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20221208.gappssmtp.com; s=20221208; t=1685741896; x=1688333896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ioz49yPI1+LPdWS/dKcafvyFW+zWutC0d0wdBopF5x0=;
        b=24ynx6fZdBgpl2nxNm2NRGW6vM9789O0zniLi9mEY3zf2EhGWMu7mL1nbRVkAgF0lx
         fNG3Qpe+lg20zN2OlImEcM0jkKht6j4Ac0dQF9XqzbQqgxJ9DW4AdcOh5OqQdG2xWqhu
         Kk6YB6hpU10gFrEs5fuXWhSCECG7brKP8Kodyq+deRPSZNox5mREgE03A70mFu2i1BvW
         gP+seIrBGHRNFyxC0x4ZqLODB26L19dguc18UgqC+PcOF6d/SvBEKpFDwr5jU1YYWs5r
         Vs9hvp4TPU0iWyEZMLuXl1Bvwyu6TTBUdRpXlRwGayT3GqEFbU7vvlptBbmbuetcPQc2
         4FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741896; x=1688333896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ioz49yPI1+LPdWS/dKcafvyFW+zWutC0d0wdBopF5x0=;
        b=EUbkZ7NH7jk5kLqPhNEFk/VNVHfUTtoNYX7lwt8XhlbxfMxFqZAi8eynI8TNXIb34v
         VDsRgLxc6dphDJvNazfmpmEZytcam6SVmefnpLANqsX3sfV+7UOnNNtRQKbaS0HvzsEM
         0rqmAwiWFqGdR2sLb+Uid/ESNmKvYxFCGaz+dJq47C4Qpy1BGA6xcnaA8gdZ9hDtma5/
         G8RHhwhSOkzYFJYs7xpVzpnU9PCTEN5dkfEGMysgP/ujOki89GuqyyElBWkDKQhXKf54
         cDUhApDc+OyzbYxI49qQ9dba0MOKVFcjSjv+UqxiU77x6ivPPGiDd6Cpuqf+BH2mF3St
         tfLA==
X-Gm-Message-State: AC+VfDxGjHaNLpRdWe+Bahp6qxaLkuekWolzeFM0Y9UpnXJmgZQXm6gO
        23snU6DbMLHGBAJGGDEeGE8FPtMBQB30h7uR4o6Q3g==
X-Google-Smtp-Source: ACHHUZ6Yfxwn3vvoBvEp075tNcy+/yLrO3jwdOKLqAGFGDjKI4LO2tqA1njdj071Fxy6/jQUUlW7Uw==
X-Received: by 2002:a0d:e20e:0:b0:565:d401:7384 with SMTP id l14-20020a0de20e000000b00565d4017384mr1406847ywe.4.1685741895436;
        Fri, 02 Jun 2023 14:38:15 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:42f0:6600:901f:39a8:fe3f:30e2])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm856302ywd.41.2023.06.02.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:38:14 -0700 (PDT)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-cxl@vger.kernel.org
Cc:     a.manzanares@samsung.com, Jonathan.Cameron@huawei.com,
        nilesh.shah@zptcorp.com, slava@dubeiko.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 0/5] CXL FM initial infrastructure
Date:   Fri,  2 Jun 2023 14:37:32 -0700
Message-Id: <20230602213737.494750-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement intitial state of Fabric Manager (FM) project.

CXL Fabric Manager (FM) is the application logic responsible for
system composition and allocation of resources. The FM can be embedded
in the firmware of a device such as a CXL switch, reside on a host,
or could be run on a Baseboard Management Controller (BMC).
CXL Specification 3.0 defines Fabric Management as: "CXL devices can be
configured statically or dynamically via a Fabric Manager (FM),
an external logical process that queries and configures the system’s
operational state using the FM commands defined in this specification.
The FM is defined as the logical process that decides when
reconfiguration is necessary and initiates the commands to perform
configurations. It can take any form, including, but not limited to,
software running on a host machine, embedded software running on a BMC,
embedded firmware running on another CXL device or CXL switch,
or a state machine running within the CXL device itself.".

CXL devices are configured by FM through the Fabric Manager Application
Programming Interface (FM API) command sets through a CCI (Component
Command Interface). A CCI is exposed through a device’s Mailbox registers
or through an MCTP-capable (Management Component Transport Protocol)
interface.

FM API Commands (defined by CXL Specification 3.0):
(1) Physical switch
    - Identify Switch Device,
    - Get Physical Port State,
    - Physical Port Control,
    - Send PPB (PCI-to-PCI Bridge) CXL.io Configuration Request.
(2) Virtual Switch
    - Get Virtual CXL Switch Info,
    - Bind vPPB (Virtual PCI-to-PCI Bridge),
    - Unbind vPPB,
    - Generate AER (Advanced Error Reporting Event).
(3) MLD Port
    - Tunnel Management Command,
    - Send LD (Logical Device) or FMLD (Fabric Manager-owned Logical Device)
      CXL.io Configuration Request,
    - Send LD CXL.io Memory Request.
(4) MLD Components
    - Get LD (Logical Device) Info,
    - Get LD Allocations,
    - Set LD Allocations,
    - Get QoS Control,
    - Set QoS Control,
    - Get QoS Status,
    - Get QoS Allocated Bandwidth,
    - Set QoS Allocated Bandwidth,
    - Get QoS Bandwidth Limit,
    - Set QoS Bandwidth Limit.
(5) Multi- Headed Devices (Get Multi-Headed Info).
(6) DCD (Dynamic Capacity Device) Management
    - Get DCD Info,
    - Get Host Dynamic Capacity Region Configuration,
    - Set Dynamic Capacity Region Configuration,
    - Get DCD Extent Lists,
    - Initiate Dynamic Capacity Add,
    - Initiate Dynamic Capacity Release.

After the initial configuration is complete and a CCI on the switch is
operational, an FM can send Management Commands to the switch.

An FM may perform the following dynamic management actions on a CXL switch:
(1) Query switch information and configuration details,
(2) Bind or Unbind ports,
(3) Register to receive and handle event notifications from the switch
    (e.g., hot plug, surprise removal, and failures).

A switch with MLD (Multi-Logical Device) requires an FM to perform
the following management activities:
(1) MLD discovery,
(2) LD (Logical Device) binding/unbinding,
(3) Management Command Tunneling.

The FM can connect to an MLD (Multi-Logical Device) over a direct connection or
by tunneling its management commands through the CCI of the CXL switch
to which the device is connected. The FM can perform the following
operations:
(1) Memory allocation and QoS Telemetry management,
(2) Security (e.g., LD erasure after unbinding),
(3) Error handling.

fm_cli - FM configuration tool
Commands:

Discover - discover available agents
Subcommands:
    - fm_cli discover fm
         (discover FM instances)
    - fm_cli discover cxl_devices
         (discover CXL devices)
    - fm_cli discover cxl_switches
         (discover CXL switches)
    - fm_cli discover logical_devices
         (discover logical devices)

FM - manage Fabric Manager
Subcommands:
    - fm_cli fm get_info
         (get FM status/info)
    - fm_cli fm start
         (start FM instance)
    - fm_cli fm restart
         (restart FM instance)
    - fm_cli fm stop
         (stop FM instance)
    - fm_cli fm get_config
         (get FM configuration)
    - fm_cli fm set_config
         (set FM configuration)
    - fm_cli fm get_events
         (get event records)

Switch - manage CXL switch
Subcommands:
    - fm_cli switch get_info
         (get CXL switch info/status)
    - fm_cli switch get_config
         (get switch configuraiton)
    - fm_cli switch set_config
         (set switch configuration)

Logical Device - manage logical devices
Subcommands:
    - fm_cli multi_headed_device info
         (retrieves the number of heads, number of supported LDs,
          and Head-to-LD mapping of a Multi-Headed device)
    - fm_cli logical_device bind
         (bind logical device)
    - fm_cli logical_device unbind
         (unbind logical device)
    - fm_cli logical_device connect
         (connect Multi Logical Device to CXL switch)
    - fm_cli logical_device disconnect
         (disconnect Multi Logical Device from CXL switch)
    - fm_cli logical_device get_allocation
         (Get LD Allocations: retrieves the memory allocations of the MLD)
    - fm_cli logical_device set_allocation
         (Set LD Allocations: sets the memory allocation for each LD)
    - fm_cli logical_device get_qos_control
         (Get QoS Control: retrieves the MLD’s QoS control parameters)
    - fm_cli logical_device set_qos_control
         (Set QoS Control: sets the MLD’s QoS control parameters)
    - fm_cli logical_device get_qos_status
         (Get QoS Status: retrieves the MLD’s QoS Status)
    - fm_cli logical_device get_qos_allocated_bandwidth
         (Get QoS Allocated Bandwidth: retrieves the MLD’s QoS allocated
          bandwidth on a per-LD basis)
    - fm_cli logical_device set_qos_allocated_bandwidth
         (Set QoS Allocated Bandwidth: sets the MLD’s QoS allocated bandwidth
          on a per-LD basis)
    - fm_cli logical_device get_qos_bandwidth_limit
         (Get QoS Bandwidth Limit: retrieves the MLD’s QoS bandwidth limit
          on a per-LD basis)
    - fm_cli logical_device set_qos_bandwidth_limit
         (Set QoS Bandwidth Limit: sets the MLD’s QoS bandwidth limit
          on a per-LD basis)
    - fm_cli logical_device erase
         (secure erase after unbinding)

PCI-to-PCI Bridge - manage PPB (PCI-to-PCI Bridge)
Subcommands:
    - fm_cli ppb config
         (Send PPB (PCI-to-PCI Bridge) CXL.io Configuration Request)
    - fm_cli ppb bind
         (Bind vPPB: Virtual PCI-to-PCI Bridge inside a CXL switch
          that is host-owned)
    - fm_cli ppb unbind
         (Unbind vPPB: unbinds the physical port or LD from the virtual
          hierarchy PPB)

Physical Port - manage physical ports
Subcommands:
    - fm_cli physical_port get_info
         (get state of physical port)
    - fm_cli physical_port control
         (control unbound ports and MLD ports, including issuing
          resets and controlling sidebands)
    - fm_cli physical_port bind
         (bind physical port to vPPB (Virtual PCI-to-PCI Bridge))
    - fm_cli physical_port unbind
         (unbind physical port from vPPB (Virtual PCI-to-PCI Bridge))

MLD (Multi-Logical Device) Port - manage Multi-Logical Device ports
Subcommands:
    - fm_cli mld_port tunnel
         (Tunnel Management Command: tunnels the provided command to
          LD FFFFh of the MLD on the specified port)
    - fm_cli mld_port send_config
         (Send LD (Logical Device) or FMLD (Fabric Manager-owned
          Logical Device) CXL.io Configuration Request)
    - fm_cli mld_port send_memory_request
         (Send LD CXL.io Memory Request)

DCD (Dynamic Capacity Device) - manage Dynamic Capacity Device
Subcommands:
    - fm_cli dcd get_info
         (Get DCD Info: retrieves the number of supported hosts,
          total Dynamic Capacity of the device, and supported region
          configurations)
    - fm_cli dcd get_capacity_config
         (Get Host Dynamic Capacity Region Configuration: retrieves
          the Dynamic Capacity configuration for a specified host)
    - fm_cli dcd set_capacity_config
         (Set Dynamic Capacity Region Configuration: sets
          the configuration of a DC Region)
    - fm_cli dcd get_extent_list
         (Get DCD Extent Lists: retrieves the Dynamic Capacity Extent
          List for a specified host)
    - fm_cli dcd add_capacity
         (Initiate Dynamic Capacity Add: initiates the addition of
          Dynamic Capacity to the specified region on a host)
    - fm_cli dcd release_capacity
         (Initiate Dynamic Capacity Release: initiates the release of
          Dynamic Capacity from a host)

FM daemon receives requests from configuration tool and executes
commands by means of interaction with kernel-space subsystems.
The responsibility of FM daemon:
    - Execute configuration tool commands
    - Manage hot-add and hot-removal of devices
    - Manage surprise removal of devices
    - Receive and handle even notifications from the CXL switch
    - Logging events
    - Memory allocation and QoS Telemetry management
    - Error/Failure handling

BUILD PROJECT:

cargo build
   Compiling proc-macro2 v1.0.49
   Compiling version_check v0.9.4
   Compiling libc v0.2.139
   Compiling unicode-ident v1.0.6
   Compiling quote v1.0.23
   Compiling syn v1.0.107
   Compiling io-lifetimes v1.0.3
   Compiling rustix v0.36.6
   Compiling linux-raw-sys v0.1.4
   Compiling bitflags v1.3.2
   Compiling heck v0.4.0
   Compiling os_str_bytes v6.4.1
   Compiling strsim v0.10.0
   Compiling termcolor v1.1.3
   Compiling clap_lex v0.3.0
   Compiling once_cell v1.17.0
   Compiling proc-macro-error-attr v1.0.4
   Compiling proc-macro-error v1.0.4
   Compiling daemonize v0.5.0
   Compiling is-terminal v0.4.2
   Compiling clap_derive v4.0.21
   Compiling clap v4.0.32
   Compiling fabric_manager v0.1.0 (/home/slavad/RUST/FM_CLI/FABRIC-MANAGER-REPO/fabric_manager)
    Finished dev [unoptimized + debuginfo] target(s) in 8.79s

START FM DAEMON:

sudo ./fm_daemon -d --ip 127.0.0.1 --port 7878
fm_daemon 0.0.1

CLI tool:

./fm_cli --ip 127.0.0.1 --port 7878 -d dcd get_info
fm_cli 0.0.1
Get Dynamic Capacity Device (DCD) info
Successfully connected to server: 127.0.0.1:7878
COMMAND: "DCD_GET_INFO\n"
RESPONCE: "NO_DATA"

FM daemon log file (/tmp/fm_daemon.log):

cat /tmp/fm_daemon.log 
fm_daemon 0.0.1: Daemonized!
Ready to accept connections: 127.0.0.1:7878
Process request...
Request: "DCD_GET_INFO"
DCD_GET_INFO
RESPONCE: "NO_DATA\n"

Viacheslav Dubeyko (5):
  CXL FM: create initial project infrastructure
  CXL FM: [lib] introduce CXL FM library
  CXL FM: [fm_daemon] introduce CXL FM daemon
  CXL FM: [fm_orchestrator] introduce CXL FM orchestrator
  CXL FM: [fm_cli] introduce CXL FM CLI tool

-- 
2.34.1

