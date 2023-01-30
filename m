Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1706C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 19:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjA3TMD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjA3TMD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 14:12:03 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AAD272D
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 11:11:37 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o5so11110369qtr.11
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X7PdXdSmR0qpHYvpJkX/wCCagFTm6NhLmMykWDCzWs=;
        b=PLpq5KruH2PbznzNCalblwbVYGRhBj20JWUZlytymnB1supoJWcTdh0H0bnh/FZsgl
         xg4BvBtOBhYbGOPQ3vMstUkk1cq86UwFXDxfxDmS7b50jiiCoeEE0zRNzmJRdPEd5358
         Jh3Xamu5Z2QHhOEuKvV2HeivYhyyw8N9gPCtVN7yg1Wa2/wbeVv6FdPzGbre8VVlKNyS
         D9592z5WzFVCrjqqQnBkUjNU397DXOwaoNoZMzlYfiqZL2RrwkJyNVJvOXmEZWT/gSi8
         sUsL/xk2ahb3oZGNRvWllQCJeL2e/xn77tok9HUhQheOzb/ALf9l3juhE7wTLcxE70xE
         B4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X7PdXdSmR0qpHYvpJkX/wCCagFTm6NhLmMykWDCzWs=;
        b=rDA4o91Yu/cGtpRwM1T0w/kPa88DQFs/2SqNW/xjXBvozabkxBhHK/405ds+Kkk76X
         gFtSz7/cOqYAJG2Yb3KGPXRgOT2Z2uvN6jTaK24pKORQqU2RguU+QYM/0raIGo1nh/4T
         tww3E0YMg1chLnEm8+aXpH/z2WI7TccNobTLhE2zFuso+FQReHWJhO63pyHjgccHulLa
         Q6rwe/JDvXrv+jXQkgezR84gy0D7IFxETnQ+lEgV+FFuhbaqVim2hn+cQxsMwNC7/uwC
         0fq9V6W4B5WStDx5VgDkLmWgAedKr1L1E4EXOV5TorBRsU6mAeATHGP5OMa9JKDrGyu8
         eb7g==
X-Gm-Message-State: AO0yUKXf2wLbmON8zDuTImKsNQDSjdCYN05VF3g1c9/iqcqtgUR9WwsJ
        tE6kWfiZHlf842ufVjwXbq457A==
X-Google-Smtp-Source: AK7set8GRLsss1SCdYF30EBK9prmDbANq1FIDq3tFVVJr2VV/ysKvfDatJKjSnXtM+ySxJAlNbEcYQ==
X-Received: by 2002:a05:622a:144b:b0:3b6:313a:e27a with SMTP id v11-20020a05622a144b00b003b6313ae27amr13603164qtx.40.1675105896162;
        Mon, 30 Jan 2023 11:11:36 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id k8-20020ac80208000000b003b1546ee6absm8589555qtg.11.2023.01.30.11.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:11:35 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: [LSF/MM/BPF TOPIC] CXL Fabric Manager (FM) architecture
Message-Id: <7F001EAF-C512-436A-A9DD-E08730C91214@bytedance.com>
Date:   Mon, 30 Jan 2023 11:11:23 -0800
Cc:     linux-mm@kvack.org, linux-cxl@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I would like to suggest Fabric Manager (FM) architecture discussion. As =
far as I can see,
FM architecture requires: (1) FM configuration tool, (2) FM daemon, (3) =
QEMU emulation
of CXL hardware features. FM daemon receives requests from configuration =
tool and
executes commands by means of interaction with kernel-space subsystem =
and CXL switch
(that can be emulated by QEMU). So, the key questions for discussion:
(1) How to distribute functionality between user-space and kernel-space?
(2) Which functionality kernel-space needs to provide for implementation =
FM features?
      Which kernel-space functionality do we need to implement yet?
(3) Do we need MCTP (Management Component Transport Protocol) or some =
other
      protocol can be used for interaction between configuration tool, =
FM daemon, and
      CXL switch?
(4) What architecture FM implementation requires?
(5) Does it make sense to use Rust as implementation language?

CXL Fabric Manager (FM) is the application logic responsible for system =
composition and
allocation of resources. The FM can be embedded in the firmware of a =
device such as
a CXL switch, reside on a host, or could be run on a Baseboard =
Management Controller (BMC).
CXL Specification 3.0 defines Fabric Management as: "CXL devices can be =
configured statically
or dynamically via a Fabric Manager (FM), an external logical process =
that queries and configures
the system=E2=80=99s operational state using the FM commands defined in =
this specification. The FM is
defined as the logical process that decides when reconfiguration is =
necessary and initiates
the commands to perform configurations. It can take any form, including, =
but not limited to,
software running on a host machine, embedded software running on a BMC, =
embedded firmware
running on another CXL device or CXL switch, or a state machine running =
within the CXL device
itself.=E2=80=9D. CXL devices are configured by FM through the Fabric =
Manager Application Programming
Interface (FM API) command sets through a CCI (Component Command =
Interface). A CCI is
exposed through a device=E2=80=99s Mailbox registers or through an =
MCTP-capable (Management
Component Transport Protocol) interface.

FM API Commands (defined by CXL Specification 3.0):
(1) Physical switch (Identify Switch Device, Get Physical Port State, =
Physical Port Control,
      Send PPB (PCI-to-PCI Bridge) CXL.io Configuration Request).
(2) Virtual Switch (Get Virtual CXL Switch Info, Bind vPPB (Virtual =
PCI-to-PCI Bridge),
      Unbind vPPB, Generate AER (Advanced Error Reporting Event).
(3) MLD Port (Tunnel Management Command, Send LD (Logical Device) or
     FMLD (Fabric Manager-owned Logical Device) CXL.io Configuration =
Request,
     Send LD CXL.io Memory Request).
(4) MLD Components (Get LD (Logical Device) Info, Get LD Allocations, =
Set LD Allocations,
     Get QoS Control, Set QoS Control, Get QoS Status, Get QoS Allocated =
Bandwidth,
     Set QoS Allocated Bandwidth, Get QoS Bandwidth Limit, Set QoS =
Bandwidth Limit).
(5) Multi-Headed Devices (Get Multi-Headed Info).
(6) DCD (Dynamic Capacity Device) Management (Get DCD Info, Get Host =
Dynamic
     Capacity Region Configuration, Set Dynamic Capacity Region =
Configuration, Get DCD
     Extent Lists, Initiate Dynamic Capacity Add, Initiate Dynamic =
Capacity Release).

After the initial configuration is complete and a CCI on the switch is =
operational, an FM can
send Management Commands to the switch. An FM may perform the following =
dynamic
management actions on a CXL switch: (1) Query switch information and =
configuration details,
(2) Bind or Unbind ports, (3) Register to receive and handle event =
notifications from the switch
(e.g., hot plug, surprise removal, and failures). A switch with MLD =
(Multi-Logical Device)
requires an FM to perform the following management activities: (1) MLD =
discovery,
(2) LD (Logical Device) binding/unbinding, (3) Management Command =
Tunneling. The FM can
connect to an MLD (Multi-Logical Device) over a direct connection or by =
tunneling its
management commands through the CCI of the CXL switch to which the =
device is connected.
The FM can perform the following operations: (1) Memory allocation and =
QoS Telemetry
management, (2) Security (e.g., LD erasure after unbinding), (3) Error =
handling.

FM configuration tool requires such commands:

Discover - discover available agents
Subcommands:
    - fm_cli discover fm - discover FM instances
    - fm_cli discover cxl_devices - discover CXL devices
    - fm_cli discover logical_devices - discover logical devices

FM - manage Fabric Manager
Subcommands:
    - fm_cli fm get_info - get FM status/info
    - fm_cli fm start - start FM instance
    - fm_cli fm restart - restart FM instance
    - fm_cli fm stop - stop FM instance
    - fm_cli fm get_config - get FM configuration
    - fm_cli fm set_config - set FM configuration
    - fm_cli fm get_events - get event records

Switch - manage CXL switch
Subcommands:
    - fm_cli switch get_info - get CXL switch info/status
    - fm_cli switch get_config - get switch configuraiton
    - fm_cli switch set_config - set switch configuration

Logical Device - manage logical devices
Subcommands:
    - fm_cli multi_headed_device info - retrieves the number of heads, =
number of
           supported LDs, and Head-to- LD mapping of a Multi-Headed =
device
    - fm_cli logical_device bind - bind logical device
    - fm_cli logical_device unbind - unbind logical device
    - fm_cli logical_device connect - connect Multi Logical Device to =
CXL switch
    - fm_cli logical_device disconnect - disconnect Multi Logical Device =
from CXL switch
    - fm_cli logical_device get_allocation - Get LD Allocations =
(retrieves the memory
           allocations of the MLD)
    - fm_cli logical_device set_allocation - Set LD Allocations (sets =
the memory allocation
           for each LD)
    - fm_cli logical_device get_qos_control - Get QoS Control (retrieves =
the MLD=E2=80=99s QoS
           control parameters)
    - fm_cli logical_device set_qos_control - Set QoS Control (sets the =
MLD=E2=80=99s QoS control
           parameters)
    - fm_cli logical_device get_qos_status - Get QoS Status (retrieves =
the MLD=E2=80=99s QoS Status)
    - fm_cli logical_device get_qos_allocated_bandwidth - Get QoS =
Allocated Bandwidth
          (retrieves the MLD=E2=80=99s QoS allocated bandwidth on a =
per-LD basis)
    - fm_cli logical_device set_qos_allocated_bandwidth - Set QoS =
Allocated Bandwidth
          (sets the MLD=E2=80=99s QoS allocated bandwidth on a per-LD =
basis)
    - fm_cli logical_device get_qos_bandwidth_limit - Get QoS Bandwidth =
Limit (retrieves the
          MLD=E2=80=99s QoS bandwidth limit on a per-LD basis)
    - fm_cli logical_device set_qos_bandwidth_limit - Set QoS Bandwidth =
Limit (sets the
          MLD=E2=80=99s QoS bandwidth limit on a per-LD basis)
    - fm_cli logical_device erase - secure erase after unbinding

PCI-to-PCI Bridge - manage PPB (PCI-to-PCI Bridge)
Subcommands:
    - fm_cli ppb config - Send PPB (PCI-to-PCI Bridge) CXL.io =
Configuration Request
    - fm_cli ppb bind - Bind vPPB (Virtual PCI-to-PCI Bridge inside a =
CXL switch that is
           host-owned)
    - fm_cli ppb unbind - Unbind vPPB (unbinds the physical port or LD =
from the virtual
           hierarchy PPB)

Physical Port - manage physical ports
Subcommands:
    - fm_cli physical_port get_info - get state of physical port
    - fm_cli physical_port control - control unbound ports and MLD =
ports, including issuing
           resets and controlling sidebands
    - fm_cli physical_port bind - bind physical port to vPPB (Virtual =
PCI-to-PCI Bridge)
    - fm_cli physical_port unbind - unbind physical port from vPPB =
(Virtual PCI-to-PCI Bridge)

MLD (Multi-Logical Device) Port - manage Multi-Logical Device ports
Subcommands:
    - fm_cli mld_port tunnel - Tunnel Management Command (tunnels the =
provided command
           to LD FFFFh of the MLD on the specified port)
    - fm_cli mld_port send_config - Send LD (Logical Device) or FMLD =
(Fabric
           Manager-owned Logical Device) CXL.io Configuration Request
    - fm_cli mld_port send_memory_request - Send LD CXL.io Memory =
Request

DCD (Dynamic Capacity Device) - manage Dynamic Capacity Device
Subcommands:
    - fm_cli dcd get_info - Get DCD Info (retrieves the number of =
supported hosts,
         total Dynamic Capacity of the device, and supported region =
configurations)
    - fm_cli dcd get_capacity_config - Get Host Dynamic Capacity Region =
Configuration
         (retrieves the Dynamic Capacity configuration for a specified =
host)
    - fm_cli dcd set_capacity_config - Set Dynamic Capacity Region =
Configuration
         (sets the configuration of a DC Region)
    - fm_cli dcd get_extent_list - Get DCD Extent Lists (retrieves the =
Dynamic Capacity
         Extent List for a specified host)
    - fm_cli dcd add_capacity - Initiate Dynamic Capacity Add (initiates =
the addition of
         Dynamic Capacity to the specified region on a host)
    - fm_cli dcd release_capacity - Initiate Dynamic Capacity Release =
(initiates the release of
         Dynamic Capacity from a host)

FM daemon receives requests from configuration tool and executes =
commands by means of
interaction with kernel-space subsystems. The responsibility of FM =
daemon could be:
    - Execute configuration tool commands
    - Manage hot-add and hot-removal of devices
    - Manage surprise removal of devices
    - Receive and handle even notifications from the CXL switch
    - Logging events
    - Memory allocation and QoS Telemetry management
    - Error/Failure handling

Thanks,
Slava.

