Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864364A11
	for <linux-cxl@vger.kernel.org>; Sun, 27 Apr 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773254; cv=none; b=D3ZnDT+/AnAJesTe/JZV70j61cHIdHVqHc6Pkdzu377rvSR29pGC4XdUu3Yz70IQ+/vQyMHakaHFJjHDdjD+wXHdeEZk/w96u4ouOa4lUmHwJMsjOn+yd7MS3knQ9LQWSIhxsFbOkckn7M5cVJ6GP9BnTWtF+o4XZI/1g6dlag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773254; c=relaxed/simple;
	bh=LE3E+PigIdNkJE8pDQtLEJUGIO+v+JoZuEyMITTz9aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZly39S38zRKZMidBobZaFG5N79RbEU5YhJew++YZPbLt5wC2SJ2Nu/9PptbqpCnYe1PzLJ/txG27FlEevdXqj2Ot+UoSe9k1kggbTynWTeTf9XwnLVEt5DXrAP6z9CYhMmrKIzKoDFeVAK04pjOG99918FV0jjWuIy4nkQFTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MXvOo2WL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MXvOo2WL"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-477282401b3so51709331cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Apr 2025 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745773250; x=1746378050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuON8zfaER6wTaz7RziY85dJjgB6j/Qsf21H+YF7rDo=;
        b=MXvOo2WLlhEN2ks2RTVOh7NUBsvJEjZxHA9zNWGICt2Nesp9lZK1ecDAyzmGNtMD5w
         Xi1sv89UoF9ZujEuZ5WxpJcWh582Drf/fqwP0FLujqRl4dy576Coy64i3My2aW+q81bI
         hd+7gQivd/cXBf4QjYO27FFl7nXHowbXl7LMkCKBYDCweY0/aE1dZoXPqdryXgohOCfj
         ZF4CulkVpJgKzLPw8xKKavO7Y6p+dtBedGzIU2nvN++teovye68mYbDwIbyQCMOqnMIw
         7aaqqchTTCC52IR59PpPkxwyclKc3+5Sh6hlPlqn1kv9l9+88Gd4soCK0WF9t9CwDu1a
         jsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745773250; x=1746378050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuON8zfaER6wTaz7RziY85dJjgB6j/Qsf21H+YF7rDo=;
        b=QYCmuePr3t+S3+qqLS/a1/TkEFMcsxG/Y13mYEnmBcmYFi9mCwv+utLdidzBssDemP
         5yXDxBc2w2wM+lQqDXHBHaHBGF9O1fOWPoiqJ3Ta1QFlmVaJG4D6M8pLvsozl+60sK5J
         aNoxW0Fu/ge+rGS04YN2/qVSBXro1XgP5hmSt2tGi+ZTt9l5wCSAZeMvbah7cs6uyLtJ
         BbR87BjrBVicSlvAZxuEfdB86s36+8VvpxtweRp+QI8b74SB8si2+JShmBCmsHo4p4jF
         9/qQLF3goa/FwWgP3fBwahgOSr3vaQtd4Q0dUn8e7t1rvhIb28kQMF0XmW9Uu9uOW+f5
         R9dg==
X-Gm-Message-State: AOJu0YzGdttnhIU4lmtfm9HurdKNZaIt0IWnhXDbXfo1nojyykIGlS+5
	aRNZPAtDTvnfVXxw/RmOp4gRiZbatfvib+HcjlW7jgY+i4tZ/xQ+NVmGn8tDQI0X9hRyLsCeVbN
	7
X-Gm-Gg: ASbGncvki7lJ63SzfZlrgSPHie3j+XwEeGINktTIxN1fJoScBDJc/bNlt77zJl2iu1G
	BUInJx6csK6/ywI2dLHg2eUv8OzcPL6UxVghSsYeZ/WOnzcbw6dKSdBZUe2jpRyVMU7BcRijgd1
	OB2K/XETqhM3/5JjLKOmDBNSysf+2XZ73H0xtRT/MtvNLO1iv+ILE8H1ckPoqspiUChUy55q0YL
	86C7LxGHdJH1m59PK9/vZEPVVkjhYY9FUFiZbZW2Wl1yJwF9/zCCYofCkTB3eujRSrTU0hMqK9N
	/MGmG3rP5PtcodNvL9b4EFIGb93HhHqvGfRySPPNno38Gx/IFR2l9gkvDLz3B8Vf5tLMQcJX/5p
	ZIZXRKmql7xPwE0ryYVtN8xtjeQPV
X-Google-Smtp-Source: AGHT+IGtbO+A4M832skMJDkkMY0yMDhwdPPrsGUKQVPk6ftJoG8lp2+uGqyzv2XxhHC85Xiy5FgTcg==
X-Received: by 2002:ac8:5753:0:b0:47a:e0d0:4f69 with SMTP id d75a77b69052e-4801cf520b9mr166629761cf.27.1745773249841;
        Sun, 27 Apr 2025 10:00:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm53027081cf.41.2025.04.27.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:00:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel-team@meta.com
Subject: [RFC DOC] cxl driver draft doc
Date: Sun, 27 Apr 2025 13:00:42 -0400
Message-ID: <20250427170042.545675-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one piece of cxl boot-to-bash series being documented here:
https://github.com/gourryinverse/cxl-boot-to-bash

This page specifically:
https://gourryinverse.github.io/cxl-boot-to-bash/linux/cxl-driver/

Asking for comments to fill in some of todo's here.  We'll start
converting the out-of-tree docs into in-tree docs in the next
couple weeks.  Dan pointed out I'll probably get better engagement
if I sent out to interested parties via email :].

Note: used format-patch here to just automate the sending, this isn't
formatted to build correct in-tree doc structure.

I'll pull in-line comments into the github, or you can submit
pull-requests to the github - whichever you prefer.

---
 Documentation/driver-api/cxl/cxl-driver.rst | 267 ++++++++++++++++++++
 1 file changed, 267 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/cxl-driver.rst

diff --git a/Documentation/driver-api/cxl/cxl-driver.rst b/Documentation/driver-api/cxl/cxl-driver.rst
new file mode 100644
index 000000000000..639fc50bfa2f
--- /dev/null
+++ b/Documentation/driver-api/cxl/cxl-driver.rst
@@ -0,0 +1,267 @@
+.. cxl driver documentation
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
+.. toctree::
+   :maxdepth: 1
+
+   cxl-cli.rst
+
+Drivers
+*******
+todo: list of drivers and probe responsibilities
+
+* cxl_core
+* cxl_port
+* cxl_acpi
+* cxl_pmem
+* cxl_mem
+* cxl_pci
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
+todo: high level explanation, also port vs dport? can we have 2 roots?
+
+::
+
+  # ls /sys/bus/cxl/devoces/root0
+    decoder0.0          dport0  dport5    port2  subsystem
+    decoders_committed  dport1  modalias  port3  uevent
+    devtype             dport4  port1     port4  uport
+
+  # cat devtype
+    cxl_port
+
+The root contains references to all host bridges (ports) and CXL Fixed
+Memory Windows (`root decoders`) described in the ACPI CEDT. ::
+
+  # cat port1/devtype
+    cxl_port
+
+  # cat decoder0.0/devtype
+    cxl_decoder_root
+
+Port
+----
+A `port` is better described as a `switch port`.  It may represent a host
+bridge connection to the root, or an actual switch port on a switch. ::
+
+  # ls /sys/bus/cxl/devices/port1
+    decoder1.0          dport0    driver     parent_dport  uport
+    decoders_committed  dport113  endpoint5  subsystem
+    devtype             dport2    modalias   uevent
+
+  # cat devtype
+    cxl_port
+
+A port contains decoders for routing to downstream ports, and may contain
+endpoints if the next port is terminal. ::
+
+  # cat decoder1.0/devtype
+    cxl_decoder_switch
+
+  # cat endpoint5/devtype
+    cxl_port
+
+Endpoint
+--------
+An `endpoint` is a terminal port in the fabric.  This is a `logical device`,
+and may be one of many `logical devices` presented by a memory device. It
+is still considered a type of `port` in the fabric. ::
+
+  # ls /sys/bus/cxl/devices/endpoint5
+
+  # cat devtype
+    cxl_port
+
+An `endpoint` contains any `endpoint decoders` for this device. ::
+
+  # cat decoder5.0/devtype
+    cxl_decoder_endpoint
+
+
+Memory Device (memdev)
+----------------------
+todo: high level explanation, why no reference to endpoint?
+
+::
+
+  # ls /sys/bus/cxl/devices/mem0
+    dev       firmware_version    payload_max  security   uevent
+    driver    label_storage_size  pmem         serial
+    firmware  numa_node           ram          subsystem
+
+
+Decoders
+========
+todo: explain the difference between decoders and how they're discovered
+
+Root Decoder
+------------
+todo:
+
+* created by CEDT CFMWS
+* target list filled by CFMWS target fields
+* targets validated against CHBS and DSDT.
+* how are memory ranges validated?
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
+Switch Decoder
+--------------
+todo:
+
+* what distinguishes it from a root decoder?
+* how is it created?
+* how does it get targets?
+* how are targets validated?
+* how are memory ranges validated?
+
+::
+
+  # ls /sys/bus/cxl/devices/decoder0.0/
+    devtype                 locked    size       target_list
+    interleave_granularity  modalias  start      target_type
+    interleave_ways         region    subsystem  uevent
+
+
+Endpoint Decoder
+----------------
+todo:
+
+* how is it created?
+* how are memory ranges validated?
+
+::
+
+  # ls /sys/bus/cxl/devices]# ls decoder5.0
+    devtype                 locked    start
+    dpa_resource            modalias  subsystem
+    dpa_size                mode      target_type
+    interleave_granularity  region    uevent
+    interleave_ways         size
+
+
+Regions
+=======
+
+Memory Region
+-------------
+todo
+::
+
+  # ls /sys/bus/cxl/devices/region0/
+    access0      devtype                 modalias  subsystem  uuid
+    access1      driver                  mode      target0
+    commit       interleave_granularity  resource  target1
+    dax_region0  interleave_ways         size      uevent
+
+DAX Region
+----------
+todo
+
+::
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
+todo: basic example of decoder programming steps.
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
+todo
+
+* CFMWS, CHBS, and Root Decoders
+
+* Decoder-type behavior (root/switch route, endpoints translate)
+
+* Unbalanced configurations are not supported by Linux.
+
+Surfacing Memory as DAX
+***********************
+todo: explain any additional steps taken to hand off control to dax
+
+Example Configurations
+**********************
+.. toctree::
+   :maxdepth: 1
+
+   example-configurations/single-device.rst
+   example-configurations/hb-interleave.rst
+   example-configurations/intra-hb-interleave.rst
+   example-configurations/multi-interleave.rst
-- 
2.49.0

