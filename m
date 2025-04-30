Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFD1C6FE0
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971972; cv=none; b=GJX7waTkxUdGb4P/HBF33ZbVgnPKTdIslbQWnZR1CrQ+L64se2CCyze9f4YtGcWbb06XJ6jKraExeMGt3zo8NYBQiPXzR86AK2eoEeF9fc0YKAwFXh2cp4hbap2gTnjR98KnP9RUSDRf1oKdAT/QgCRTPEbue4PGb6iC6VpToY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971972; c=relaxed/simple;
	bh=r7NFqhv2nT1cBSxaAUpORyHo5B+6APjNFmDOdZGh7jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP7iPeakskTVEzFV7nDQwhtLQsd9SA6wktdZW4MClllJh8adwnWeW5KgCm7DJnwjTz5DGEQmdFZ8kqndHXJbTtyKYpJ91/jx9QfbD0PKYq+laH7cJRqCTTo7DG51JsLwQ7U35WgHQsWsBsmvhstlviRk5bz/zpSMadGTiXGZIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RNQxTE2U; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RNQxTE2U"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774d68c670so114320271cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971969; x=1746576769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17vD1ZJMB9GHCWFotVbxEr5M0DwafWGgiCu9VsxYk/U=;
        b=RNQxTE2UZcStv4EnrY+vSjiVSowmU++f9/IvwafUarZV2wVM4nDdqmEJ5qPGyb2Fq6
         5uGXunQShg4Ncp/O8Sby3JW+x1P4VBDrzxQvuJ0araQY0V0NvCcu8OGpW+ZnqMY2Op4m
         U5nYMU4WHFtDJNRwQfX4MH8+B1s9NQ6zi3saZLHT/dbg+clTJhwtAiQMuMlCIYS0CmGg
         PYGrf0l6BymUrHh8FOE0wXnnF1rZB8wYsf+MesTW+/bRnvRhrLZUtKAiWzUK75TvOxOE
         pRhXU5cMuU7vkGDhU8Mn3QnlS2dd2GWaupaxKDuQsHG+MZG2iIQQs2+5YQVpJeN1lo/Z
         SGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971969; x=1746576769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17vD1ZJMB9GHCWFotVbxEr5M0DwafWGgiCu9VsxYk/U=;
        b=qJvLb2ZQ4ma1Nh9b0KL+bwl6t0AGt3qvN/cyuxkIs0duVHO0gtK4CySi+u7YvWBbUG
         o1DVBHguyH+ro5V9eEhCAnCtZBZzwswwgVTFYN6Vl43WVQdI1S2puJLRsb9vsn7ZgINO
         UDoERd8YIfQaL2ugZNh6xiWgY3FcfcJc6jWUzhJx3pEGMcX2OK6Gy/nFlWK71ZzSnjKN
         JvYKMyNXLgnRbQA/9YxYnsu2qa5CjpVTJmKE2Pysf/isB7oyVyQ+lqPXQjAAdTWXgYT+
         WctVDno7n8SyhzGv6g3zGPdQGK/AwQP3aoGfxDadDdyYrPDtE9vdCshHb3ACCsx59zFS
         GT5w==
X-Gm-Message-State: AOJu0Yw7v3oFDAGDh3iFgUvKIOYatOd+AL4UVZYI4q8i1MpezRPCaW2J
	/An+XZgMKsFHHv+X3jhTRhLMSreI1jfKI8WjTBsmLdIwwqzNymNF4SskbaNWy5hjp4RUap1omMW
	n
X-Gm-Gg: ASbGncvdy9Od9xAGU8bwJmCIs0g0sgExjW7vUk60ipZh0M8ARW1eSwOyOjZTTL9RH6z
	CIjHzYCGhDjFv6YMETO/si2i8hDgjE6tVg2sgpffygZZzoRIY8AXXYyp1ZOTgrmKexD6/jUVXsz
	cZG2EM+ztHAdUInEZyRtUVqnsJzUJkxJsCBG0OTfF/eLawwNlnNmoRE5NcJ2WWKqDdT2zo+jbCx
	dx9dT7Jt+2I4hzylydR7b7yxcEAzIJ3NbRs/XtW8ZhGN/97oMnvqnjkm25NJndiKTkSfTzryAnD
	xktO5IDlc5KUb+jMieafq0thoQgA1yN6A58MuEM5KAQH7uS9kOX/yQvX8japOVeBO4Wqv7s0+eU
	EaU61GzdkHjFbhjeZC/yPeEzS3KNb
X-Google-Smtp-Source: AGHT+IFtCfbX47An8N8+VKAkxzfsQgqHg5Cwzaxupcx9dVEzxCh6E3PguwQHjTEefZfrbCdjCgjbnw==
X-Received: by 2002:a05:622a:1f8d:b0:476:a6bc:a94d with SMTP id d75a77b69052e-489e4a8df67mr12766091cf.19.1745971968682;
        Tue, 29 Apr 2025 17:12:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:47 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH 08/17] cxl: docs/linux - add cxl-driver theory of operation
Date: Tue, 29 Apr 2025 20:12:15 -0400
Message-ID: <20250430001224.1028656-9-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add docs for the CXL driver that explains the base devices,
decoder types, region types, mailbox interfaces, and decoder
programming.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/linux/cxl-driver.rst       | 521 ++++++++++++++++++
 2 files changed, 522 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/cxl-driver.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index da74480207b7..b915ce982048 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -37,6 +37,7 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    linux/overview
    linux/early-boot
+   linux/cxl-driver
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
new file mode 100644
index 000000000000..f403804648b1
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -0,0 +1,521 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+CXL Driver Operation
+####################
+
+The devices described in this section are present in ::
+
+  /sys/bus/cxl/devices/
+  /dev/cxl/
+
+The :code:`cxl-cli` library, maintained as part of the NDTCL project, may
+be used to script interactions with these devices.
+
+Drivers
+*******
+The CXL driver is split into a number of drivers.
+
+* cxl_core  - fundamental init interface and core object creation
+* cxl_port  - initializes root and provides port enumeration interface.
+* cxl_acpi  - initializes root decoders and interacts with ACPI data.
+* cxl_p/mem - initializes memory devices
+* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
+
+Driver Devices
+**************
+Here is an example from a single-socket system with 4 host bridges. Two host
+bridges have a single memory device attached, and the devices are interleaved
+into a single memory region. The memory region has been converted to dax. ::
+
+  # ls /sys/bus/cxl/devices/
+    dax_region0  decoder3.0  decoder6.0  mem0   port3
+    decoder0.0   decoder4.0  decoder6.1  mem1   port4
+    decoder1.0   decoder5.0  endpoint5   port1  region0
+    decoder2.0   decoder5.1  endpoint6   port2  root0
+
+For this section we'll explore the devices present in this configuration, but
+we'll explore more configurations in-depth in example configurations below.
+
+Base Devices
+============
+Most devices in a CXL fabric are a `port` of some kind (because each
+device mostly routes request from one device to the next, rather than
+provide a manageable service).
+
+Root
+----
+The `CXL Root` is logical object created by the `cxl_acpi` driver during
+:code:`cxl_acpi_probe` - if the :code:`ACPI0017` `Compute Express Link
+Root Object` Device Class is found.
+
+The Root contains links to:
+
+* `Host Bridge Ports` defined by ACPI CEDT CHBS.
+
+* `Root Decoders` defined by ACPI CEDT CFMWS.
+
+::
+
+  # ls /sys/bus/cxl/devices/root0
+    decoder0.0          dport0  dport5    port2  subsystem
+    decoders_committed  dport1  modalias  port3  uevent
+    devtype             dport4  port1     port4  uport
+
+  # cat /sys/bus/cxl/devices/root0/devtype
+    cxl_port
+
+  # cat port1/devtype
+    cxl_port
+
+  # cat decoder0.0/devtype
+    cxl_decoder_root
+
+The root is first `logical port` in the CXL fabric, as presented by the Linux
+CXL driver.  The `CXL root` is a special type of `switch port`, in that it
+only has downstream port connections.
+
+Port
+----
+A `port` object is better described as a `switch port`.  It may represent a
+host bridge to the root or an actual switch port on a switch. A `switch port`
+contains one or more decoders used to route memory requests downstream ports,
+which may be connected to another `switch port` or an `endpoint port`.
+
+::
+
+  # ls /sys/bus/cxl/devices/port1
+    decoder1.0          dport0    driver     parent_dport  uport
+    decoders_committed  dport113  endpoint5  subsystem
+    devtype             dport2    modalias   uevent
+
+  # cat devtype
+    cxl_port
+
+  # cat decoder1.0/devtype
+    cxl_decoder_switch
+
+  # cat endpoint5/devtype
+    cxl_port
+
+CXL `Host Bridges` in the fabric are probed during :code:`cxl_acpi_probe` at
+the time the `CXL Root` is probed.  The allows for the immediate logical
+connection to between the root and host bridge.
+
+* The root has a downstream port connection to a host bridge
+
+* The host bridge has an upstream port connection to the root.
+
+* The host bridge has one or more downstream port connections to switch
+  or endpoint ports.
+
+A `Host Bridge` is a special type of CXL `switch port`. It is explicitly
+defined in the ACPI specification via `ACPI0016` ID.  `Host Bridge` ports
+will be probed at `acpi_probe` time, while similar ports on an actual switch
+will be probed later.  Otherwise, switch and host bridge ports look very
+similar - the both contain switch decoders which route accesses between
+upstream and downstream ports.
+
+Endpoint
+--------
+An `endpoint` is a terminal port in the fabric.  This is a `logical device`,
+and may be one of many `logical devices` presented by a memory device. It
+is still considered a type of `port` in the fabric.
+
+An `endpoint` contains `endpoint decoders` available for use and the
+*Coherent Device Attribute Table* (CDAT) used to describe the capabilities
+of the device. ::
+
+  # ls /sys/bus/cxl/devices/endpoint5
+    CDAT        decoders_committed  modalias      uevent
+    decoder5.0  devtype             parent_dport  uport
+    decoder5.1  driver              subsystem
+
+  # cat /sys/bus/cxl/devices/endpoint5/devtype
+    cxl_port
+
+  # cat /sys/bus/cxl/devices/endpoint5/decoder5.0/devtype
+    cxl_decoder_endpoint
+
+
+Memory Device (memdev)
+----------------------
+A `memdev` is probed and added by the `cxl_pci` driver in :code:`cxl_pci_probe`
+and is managed by the `cxl_mem` driver. It primarily provides the `IOCTL`
+interface to a memory device, via :code:`/dev/cxl/memN`, and exposes various
+device configuration data. ::
+
+  # ls /sys/bus/cxl/devices/mem0
+    dev       firmware_version    payload_max  security   uevent
+    driver    label_storage_size  pmem         serial
+    firmware  numa_node           ram          subsystem
+
+
+Decoders
+========
+A `Decoder` is short for a CXL Host-Managed Device Memory (HDM) Decoder. It is
+a device that routes accesses through the CXL fabric to an endpoint, and at
+the endpoint translates a `Host Physical` to `Device Physical` Addressing.
+
+The CXL 3.1 specification heavily implies that only endpoint decoders should
+engage in translation of `Host Physical Address` to `Device Physical Address`.
+::
+
+  8.2.4.20 CXL HDM Decoder Capability Structure
+
+  IMPLEMENTATION NOTE
+  CXL Host Bridge and Upstream Switch Port Decode Flow
+
+  IMPLEMENTATION NOTE
+  Device Decode Logic
+
+These notes imply that there are two logical groups of decoders.
+
+* Routing Decoder - a decoder which routes accesses but does not translate
+  addresses from HPA to DPA.
+
+* Translating Decoder - a decoder which translates accesses from HPA to DPA
+  for an endpoint to service.
+
+The CXL drivers distinguish 3 decoder types: root, switch, and endpoint. Only
+endpoint decoders are Translating Decoders, all others are Routing Decoders.
+
+.. note:: PLATFORM VENDORS BE AWARE
+
+   Linux makes a strong assumption that endpoint decoders are the only decoder
+   in the fabric that actively translates HPA to DPA.  Linux assumes routing
+   decoders pass the HPA unchanged to the next decoder in the fabric.
+
+   It is therefore assumed that any given decoder in the fabric will have an
+   address range that is a subset of its upstream port decoder. Any deviation
+   from this scheme undefined per the specification.  Linux prioritizes
+   spec-defined / architectural behavior.
+
+Decoders may have one or more `Downstream Targets` if configured to interleave
+memory accesses.  This will be presented in sysfs via the :code:`target_list`
+parameter.
+
+Root Decoder
+------------
+A `Root Decoder` is logical construct of the physical address and interleave
+configurations present in the ACPI CEDT CFMWS.  Linux presents this information
+as a decoder present in the `CXL Root`.  We consider this a `Root Decoder`,
+though technically it exists on the boundary of the CXL specification and
+platform-specific CXL root implementations.
+
+Linux considers these logical decoders a type of `Routing Decoder`, and is the
+first decoder in the CXL fabric to receive a memory access from the platform's
+memory controllers.
+
+`Root Decoders` are created during :code:`cxl_acpi_probe`.  One root decoder
+is created per CFMWS entry in the ACPI CEDT.
+
+The :code:`target_list` parameter is filled by the CFMWS target fields. Targets
+of a root decoder are `Host Bridges`, which means interleave done at the root
+decoder level is an `Inter-Host-Bridge Interleave`.
+
+Only root decoders are capable of `Inter-Host-Bridge Interleave`.
+
+Such interleaves must be configured by the platform and described in the ACPI
+CEDT CFMWS, as the target CXL host bridge UIDs in the CFMWS must match the CXL
+host bridge UIDs in the ACPI CEDT CHBS and ACPI DSDT.
+
+Interleave settings in a rootdecoder describe how to interleave accesses among
+the *immediate downstream targets*, not the entire interleave set.
+
+The memory range described in the root decoder is used to
+
+1) Create a memory region (:code:`region0` in this example), and
+
+2) Associate the region with an IO Memory Resource (:code:`kernel/resource.c`)
+
+::
+
+  # ls /sys/bus/cxl/devices/decoder0.0/
+    cap_pmem           devtype                 region0
+    cap_ram            interleave_granularity  size
+    cap_type2          interleave_ways         start
+    cap_type3          locked                  subsystem
+    create_ram_region  modalias                target_list
+    delete_region      qos_class               uevent
+
+  # cat /sys/bus/cxl/devices/decoder0.0/region0/resource
+    0xc050000000
+
+The IO Memory Resource is created during early boot when the CFMWS region is
+identified in the EFI Memory Map or E820 table (on x86).
+
+Root decoders are defined as a separate devtype, but are also a type
+of `Switch Decoder` due to having downstream targets. ::
+
+  # cat /sys/bus/cxl/devices/decoder0.0/devtype
+    cxl_decoder_root
+
+Switch Decoder
+--------------
+Any non-root, translating decoder is considered a `Switch Decoder`, and will
+present with the type :code:`cxl_decoder_switch`. Both `Host Bridge` and `CXL
+Switch` (device) decoders are of type :code:`cxl_decoder_switch`. ::
+
+  # ls /sys/bus/cxl/devices/decoder1.0/
+    devtype                 locked    size       target_list
+    interleave_granularity  modalias  start      target_type
+    interleave_ways         region    subsystem  uevent
+
+  # cat /sys/bus/cxl/devices/decoder1.0/devtype
+    cxl_decoder_switch
+
+  # cat /sys/bus/cxl/devices/decoder1.0/region
+    region0
+
+A `Switch Decoder` has associations between a region defined by a root
+decoder and downstream target ports.  Interleaving done within a switch decoder
+is a multi-downstream-port interleave (or `Intra-Host-Bridge Interleave` for
+host bridges).
+
+Interleave settings in a switch decoder describe how to interleave accesses
+among the *immediate downstream targets*, not the entire interleave set.
+
+Switch decoders are created during :code:`cxl_switch_port_probe` in the
+:code:`cxl_port` driver, and is created based on a PCI device's DVSEC
+registers.
+
+Switch decoder programming is validated during probe if the platform programs
+them during boot (See `Auto Decoders` below), or on commit if programmed at
+runtime (See `Runtime Programming` below).
+
+
+Endpoint Decoder
+----------------
+Any decoder attached to a *terminal* point in the CXL fabric (`An Endpoint`) is
+considered an `Endpoint Decoder`. Endpoint decoders are of type
+:code:`cxl_decoder_endpoint`. ::
+
+  # ls /sys/bus/cxl/devices/decoder5.0
+    devtype                 locked    start
+    dpa_resource            modalias  subsystem
+    dpa_size                mode      target_type
+    interleave_granularity  region    uevent
+    interleave_ways         size
+
+  # cat /sys/bus/cxl/devices/decoder5.0/devtype
+    cxl_decoder_endpoint
+
+  # cat /sys/bus/cxl/devices/decoder5.0/region
+    region0
+
+An `Endpoint Decoder` has an association with a region defined by a root
+decoder and describes the device-local resource associated with this region.
+
+Unlike root and switch decoders, endpoint decoders translate `Host Physical` to
+`Device Physical` address ranges.  The interleave settings on an endpoint
+therefore describe the entire *interleave set*.
+
+`Device Physical Address` regions must be committed in-order. For example, the
+DPA region starting at 0x80000000 cannot be committed before the DPA region
+starting at 0x0.
+
+As of Linux v6.15, Linux does not support *imbalanced* interleave setups, all
+endpoints in an interleave set are expected to have the same interleave
+settings (granularity and ways must be the same).
+
+Endpoint decoders are created during :code:`cxl_endpoint_port_probe` in the
+:code:`cxl_port` driver, and is created based on a PCI device's DVSEC registers.
+
+Regions
+=======
+
+Memory Region
+-------------
+A `Memory Region` is a logical construct that connects a set of CXL ports in
+the fabric to an IO Memory Resource.  It is ultimately used to expose the memory
+on these devices to the DAX subsystem via a `DAX Region`.
+
+An example RAM region: ::
+
+  # ls /sys/bus/cxl/devices/region0/
+    access0      devtype                 modalias  subsystem  uuid
+    access1      driver                  mode      target0
+    commit       interleave_granularity  resource  target1
+    dax_region0  interleave_ways         size      uevent
+
+A memory region can be constructed during endpoint probe, if decoders were
+programmed by BIOS/EFI (see `Auto Decoders`), or by creating a region manually
+via a `Root Decoder`'s :code:`create_ram_region` or :code:`create_pmem_region`
+interfaces.
+
+The interleave settings in a `Memory Region` describe the configuration of the
+`Interleave Set` - and are what can be expected to be seen in the endpoint
+interleave settings.
+
+
+DAX Region
+----------
+A `DAX Region` is used to convert a CXL `Memory Region` to a DAX device. A
+DAX device may then be accessed directly via a file descriptor interface, or
+converted to System RAM via the DAX kmem driver.  See the DAX driver section
+for more details. ::
+
+  # ls /sys/bus/cxl/devices/dax_region0/
+    dax0.0      devtype  modalias   uevent
+    dax_region  driver   subsystem
+
+
+Mailbox Interfaces
+==================
+A mailbox command interface for each device is exposed in ::
+
+  /dev/cxl/mem0
+  /dev/cxl/mem1
+
+These mailboxes may receive any specification-defined command. Raw commands
+(custom commands) can only be sent to these interfaces if the build config
+:code:`CXL_MEM_RAW_COMMANDS` is set.  This is considered a debug and/or
+development interface, not an officially supported mechanism for creation
+of vendor-specific commands (see the `fwctl` subsystem for that).
+
+Decoder Programming
+*******************
+
+Runtime Programming
+===================
+During probe, the only decoders *required* to be programmed are `Root Decoders`.
+In reality, `Root Decoders` are a logical construct to describe the memory
+region and interleave configuration at the host bridge level - as described
+in the ACPI CEDT CFMWS.
+
+All other `Switch` and `Endpoint` decoders may be programmed by the user
+at runtime - if the platform supports such configurations.
+
+This interaction is what creates a `Software Defined Memory` environment.
+
+See the :code:`cxl-cli` documentation for more information about how to
+configure CXL decoders at runtime.
+
+Auto Decoders
+=============
+Auto Decoders are decoders programmed by BIOS/EFI at boot time, and are
+almost always locked (cannot be changed).  This is done by a platform
+which may have a static configuration - or certain quirks which may prevent
+dynamic runtime changes to the decoders (such as requiring additional
+controller programming within the CPU complex outside the scope of CXL).
+
+Auto Decoders are probed automatically as long as the devices and memory
+regions they are associated with probe without issue.  When probing Auto
+Decoders, the driver's primary responsibility is to ensure the fabric is
+sane - as-if validating runtime programmed regions and decoders.
+
+If Linux cannot validate auto-decoder configuration, the memory will not
+be surfaced as a DAX device - and therefore not be exposed to the page
+allocator - effectively stranding it.
+
+Interleave
+==========
+
+The Linux CXL driver supports `Cross-Link First` interleave. This dictates
+how interleave is programmed at each decoder step, as the driver validates
+the relationships between a decoder and it's parent.
+
+For example, in a `Cross-Link First` interleave setup with 16 endpoints
+attached to 4 host bridges, linux expects the following ways/granularity
+across the root, host bridge, and endpoints respectively. ::
+
+                   ways   granularity
+  root              4        256
+  host bridge       4       1024
+  endpoint         16        256
+
+At the root, every a given access will be routed to the
+:code:`((HPA / 256) % 4)th` target host bridge. Within a host bridge, every
+:code:`((HPA / 1024) % 4)th` target endpoint.  Each endpoint will translate
+the access based on the entire 16 device interleave set.
+
+Unbalanced interleave sets are not supported - decoders at a similar point
+in the hierarchy (e.g. all host bridge decoders) must have the same ways and
+granularity configuration.
+
+At Root
+-------
+Root decoder interleave is defined by the ACPI CEDT CFMWS.  The CEDT
+may actually define multiple CFMWS configurations to describe the same
+physical capacity - with the intent to allow users to decide at runtime
+whether to online memory as interleaved or non-interleaved. ::
+
+             Subtable Type : 01 [CXL Fixed Memory Window Structure]
+       Window base address : 0000000100000000
+               Window size : 0000000100000000
+  Interleave Members (2^n) : 00
+     Interleave Arithmetic : 00
+              First Target : 00000007
+
+             Subtable Type : 01 [CXL Fixed Memory Window Structure]
+       Window base address : 0000000200000000
+               Window size : 0000000100000000
+  Interleave Members (2^n) : 00
+     Interleave Arithmetic : 00
+              First Target : 00000006
+
+             Subtable Type : 01 [CXL Fixed Memory Window Structure]
+       Window base address : 0000000300000000
+               Window size : 0000000200000000
+  Interleave Members (2^n) : 01
+     Interleave Arithmetic : 00
+              First Target : 00000007
+               Next Target : 00000006
+
+In this example, the CFMWS defines two discrete non-interleaved 4GB regions
+for each host bridge, and one interleaved 8GB region that targets both. This
+would result in 3 root decoders presenting in the root. ::
+
+  # ls /sys/bus/cxl/devices/root0
+    decoder0.0  decoder0.1  decoder0.2
+
+  # cat /sys/bus/cxl/devices/decoder0.0/target_list start size
+    7
+    0x100000000
+    0x100000000
+
+  # cat /sys/bus/cxl/devices/decoder0.1/target_list start size
+    6
+    0x200000000
+    0x100000000
+
+  # cat /sys/bus/cxl/devices/decoder0.2/target_list start size
+    7,6
+    0x300000000
+    0x200000000
+
+These decoders are not runtime programmable.  They are used to generate a
+`Memory Region` to bring this memory online with runtime programmed settings
+at the `Switch` and `Endpoint` decoders.
+
+At Host Bridge or Switch
+------------------------
+`Host Bridge` and `Switch` decoders are programmable via the following fields:
+
+- :code:`start` - the HPA region associated with the memory region
+- :code:`size` - the size of the region
+- :code:`target_list` - the list of downstream ports
+- :code:`interleave_ways` - the number downstream ports to interleave across
+- :code:`interleave_granularity` - the granularity to interleave at.
+
+Linux expects the :code:`interleave_granularity` of switch decoders to be
+derived from their upstream port connections. In `Cross-Link First` interleave
+configurations, the :code:`interleave_granularity` of a decoder is equal to
+:code:`parent_interleave_granularity * parent_interleave_ways`.
+
+At Endpoint
+-----------
+`Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
+with the exception that the ways and granularity are defined by the interleave
+set (e.g. the interleave settings defined by the associated `Memory Region`).
+
+- :code:`start` - the HPA region associated with the memory region
+- :code:`size` - the size of the region
+- :code:`interleave_ways` - the number endpoints in the interleave set
+- :code:`interleave_granularity` - the granularity to interleave at.
+
+These settings are used by endpoint decoders to *Translate* memory requests
+from HPA to DPA.  This is why they must be aware of the entire interleave set.
+
+Linux does not support unbalanced interleave configurations.  As a result, all
+endpoints in an interleave set must have the same ways and granularity.
-- 
2.49.0

