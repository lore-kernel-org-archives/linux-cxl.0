Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355625291B
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066923; cv=none; b=j+fRmdbKlQXCkuhKDodFOUuBq8TM/pUnIORncwZk1wE/u7TrZ5RKRNg1DoYSZT3xk7ypKt+yNOxAhuqZ6dUXHwVoRMuI67XWPqwZCOR8/yXrEpQQNdZCc20BSSrIjODH3xwpHA0KbTfBzMCxxhD48+u2DV85/VZdTzrUblSbRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066923; c=relaxed/simple;
	bh=dkaGPWOKn67y1LdrfoERITXLH++9yici8wbfaUCIToA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIPk9Z7WouPgHKi7BT15KBqZOfWVDqHg+sqwBJ7I8ASUL8GBNhJlXmx31wDXROA1pdgtqrU60m3GOBafz2oOgiCubYPkDIRlbHzN+DATV9LpYg3iNIzW1jqn5l0nqq9zVEwlsj47zpTZfXchZEViaAw9pH5Drv/hM1zf2/l4PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KR3YSgJe; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KR3YSgJe"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476af5479feso55101671cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066918; x=1747671718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FdhR4gF7aeY7QZzxz+jvh/0OURCPCws/RHYlQ0UyrA=;
        b=KR3YSgJevCKKUokIbOMbhPeN6Q/PEjC2vf+hjqem8HlfIpA6LYdeJ0YBmO3oBrDhBn
         SR+lwesqTDcOlUOKvhKarKmGO5eOO96pAafM4IJ6z0AmlR0YB8NnH9M5iDfCwj6IZw+8
         nWv+lBNW9YzgDQXIpa0WhNaDNBVUuwVh3uIqyMagwpWMAwp5VrokMArL6AmTP2CA+miJ
         /lGjfgmFbJmT0D+wDImOuBcC0qpGmuvtH1S/TqVvbKZ12b/k14JpMv5+PuxDwnKsldv2
         JmIyrMD2bVju5mpAjGjdHMdsxxE+p3S0ZQKJ26KBXVBzqdaLHB4cx/3N1NqXcZ93/WvG
         Ie2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066918; x=1747671718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FdhR4gF7aeY7QZzxz+jvh/0OURCPCws/RHYlQ0UyrA=;
        b=PXbWOnvbC+95ygOt+vqttsagwt6IeRDHFIFJ6JloZAI3jLOyMP8AT9RW1oMZ4xB3/Y
         2VoMIOF9hmlfXMuBXpBEdzmyaOjXUJ1R89oicDIG0wPEL13bW84+iSWBPmsFdGQMB3ew
         wwRgH6Y0owuTO5WIqPxYB5rAH0smV3rpVzPoiuTKo6yFI8kP3aTVnko/IASvfEI/B6wu
         vH/A2bZhsIO+uRj2hv8BoER9Svshzp6mUysJgTye47pXiPeN/crXiZTKtZ3MnZUEQPM0
         ENRYB28zZEaBd9cEzO1dfTv53hxkmikvKBqRVSEXFcKo2NBR9SlTQ+dAJ2wcUkEYM0UW
         1AXA==
X-Gm-Message-State: AOJu0YyXoyXmzfVN84vqQ7TfhDDYvcItaX50w7Iep5QZoKUKTwXGXST3
	H2pQX8orlz3jHmr3TYFjfJj8rvcBQxZsxHBgNgovp8hKytnralPX07wrRbD56YVj6fl/rJEoOfX
	e
X-Gm-Gg: ASbGncvdD7IO5h86WbNZwEy8aVTzJy8rtnKa5Slrg0BaUkhafUyPtGRnbMJIG/3aAJs
	Ne4rdHhNCklLQ6AiKtLR8kHHZiUtdM2TfSBgs4Np/opY+sVbao7SjiNUBjrzr7GaRIdCp/Yv82g
	zn1a6LaIC7LXG+NX6jqPqntGdZCltUCdnr2qpLoiI5fa0oe456gzqpWdtwasNm9K6qm+r8s0F/S
	M4oLuG6pfwmS4BX7Toppin7o1qzMQSJiPU8AZbLTv4PmwgRE4A1gIm6dg8ycMWYl0n/mId2lB3C
	EZ7fnqiARiTCi7f7ZbtKF7WewkGc2N9wjpLZnZ/Efgtb2q59ywJ0OxzbqaqEIFUq9T6y35qffLm
	YjLactAA6snU3fsmzBoZhjcObp8DOrqKdL1AA
X-Google-Smtp-Source: AGHT+IH1RVRuM5ahaMr9cwa2/lm9WOHwEChS2vTespRCGjkzQZA4dRtetghuz1xpgoLde/jPXjNNzA==
X-Received: by 2002:a05:622a:d1:b0:476:875e:516d with SMTP id d75a77b69052e-494527d5051mr200467781cf.36.1747066917643;
        Mon, 12 May 2025 09:21:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:57 -0700 (PDT)
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
Subject: [PATCH v3 10/17] cxl: docs/linux/cxl-driver - add example configurations
Date: Mon, 12 May 2025 12:21:27 -0400
Message-ID: <20250512162134.3596150-11-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 4 example configurations:
- single device
- cross-host-bridge interleave
- intra-host-bridge-interleave
- multi-level interleave

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/linux/cxl-driver.rst       |  10 +
 .../example-configurations/hb-interleave.rst  | 314 ++++++++++++++
 .../intra-hb-interleave.rst                   | 291 +++++++++++++
 .../multi-interleave.rst                      | 401 ++++++++++++++++++
 .../example-configurations/single-device.rst  | 246 +++++++++++
 5 files changed, 1262 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/single-device.rst

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index 9a9e8ecee578..486baf8551aa 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -520,3 +520,13 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
 
 Linux does not support unbalanced interleave configurations.  As a result, all
 endpoints in an interleave set must have the same ways and granularity.
+
+Example Configurations
+======================
+.. toctree::
+   :maxdepth: 1
+
+   example-configurations/single-device.rst
+   example-configurations/hb-interleave.rst
+   example-configurations/intra-hb-interleave.rst
+   example-configurations/multi-interleave.rst
diff --git a/Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
new file mode 100644
index 000000000000..f071490763a2
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
@@ -0,0 +1,314 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Inter-Host-Bridge Interleave
+============================
+This cxl-cli configuration dump shows the following host configuration:
+
+* A single socket system with one CXL root
+* CXL Root has Four (4) CXL Host Bridges
+* Two CXL Host Bridges have a single CXL Memory Expander Attached
+* The CXL root is configured to interleave across the two host bridges.
+
+This output is generated by :code:`cxl list -v` and describes the relationships
+between objects exposed in :code:`/sys/bus/cxl/devices/`.
+
+::
+
+  [
+    {
+        "bus":"root0",
+        "provider":"ACPI.CXL",
+        "nr_dports":4,
+        "dports":[
+            {
+                "dport":"pci0000:00",
+                "alias":"ACPI0016:01",
+                "id":0
+            },
+            {
+                "dport":"pci0000:a8",
+                "alias":"ACPI0016:02",
+                "id":4
+            },
+            {
+                "dport":"pci0000:2a",
+                "alias":"ACPI0016:03",
+                "id":1
+            },
+            {
+                "dport":"pci0000:d2",
+                "alias":"ACPI0016:00",
+                "id":5
+            }
+        ],
+
+This chunk shows the CXL "bus" (root0) has 4 downstream ports attached to CXL
+Host Bridges.  The `Root` can be considered the singular upstream port attached
+to the platform's memory controller - which routes memory requests to it.
+
+The `ports:root0` section lays out how each of these downstream ports are
+configured.  If a port is not configured (id's 0 and 1), they are omitted.
+
+::
+
+        "ports:root0":[
+            {
+                "port":"port1",
+                "host":"pci0000:d2",
+                "depth":1,
+                "nr_dports":3,
+                "dports":[
+                    {
+                        "dport":"0000:d2:01.1",
+                        "alias":"device:02",
+                        "id":0
+                    },
+                    {
+                        "dport":"0000:d2:01.3",
+                        "alias":"device:05",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:d2:07.1",
+                        "alias":"device:0d",
+                        "id":113
+                    }
+                ],
+
+This chunk shows the available downstream ports associated with the CXL Host
+Bridge :code:`port1`.  In this case, :code:`port1` has 3 available downstream
+ports: :code:`dport1`, :code:`dport2`, and :code:`dport113`..
+
+::
+
+                "endpoints:port1":[
+                    {
+                        "endpoint":"endpoint5",
+                        "host":"mem0",
+                        "parent_dport":"0000:d2:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem0",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:d3:00.0"
+                        },
+                        "decoders:endpoint5":[
+                            {
+                                "decoder":"decoder5.0",
+                                "resource":825975898112,
+                                "size":274877906944,
+                                "interleave_ways":2,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+
+This chunk shows the endpoints attached to the host bridge :code:`port1`.
+
+:code:`endpoint5` contains a single configured decoder :code:`decoder5.0`
+which has the same interleave configuration as :code:`region0` (shown later).
+
+Next we have the decodesr belonging to the host bridge:
+
+::
+
+                "decoders:port1":[
+                    {
+                        "decoder":"decoder1.0",
+                        "resource":825975898112,
+                        "size":274877906944,
+                        "interleave_ways":1,
+                        "region":"region0",
+                        "nr_targets":1,
+                        "targets":[
+                            {
+                                "target":"0000:d2:01.1",
+                                "alias":"device:02",
+                                "position":0,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+Host Bridge :code:`port1` has a single decoder (:code:`decoder1.0`), whose only
+target is :code:`dport1` - which is attached to :code:`endpoint5`.
+
+The following chunk shows a similar configuration for Host Bridge :code:`port3`,
+the second host bridge with a memory device attached.
+
+::
+
+            {
+                "port":"port3",
+                "host":"pci0000:a8",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:a8:01.1",
+                        "alias":"device:c3",
+                        "id":0
+                    }
+                ],
+                "endpoints:port3":[
+                    {
+                        "endpoint":"endpoint6",
+                        "host":"mem1",
+                        "parent_dport":"0000:a8:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem1",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:a9:00.0"
+                        },
+                        "decoders:endpoint6":[
+                            {
+                                "decoder":"decoder6.0",
+                                "resource":825975898112,
+                                "size":274877906944,
+                                "interleave_ways":2,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+                "decoders:port3":[
+                    {
+                        "decoder":"decoder3.0",
+                        "resource":825975898112,
+                        "size":274877906944,
+                        "interleave_ways":1,
+                        "region":"region0",
+                        "nr_targets":1,
+                        "targets":[
+                            {
+                                "target":"0000:a8:01.1",
+                                "alias":"device:c3",
+                                "position":0,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+
+The next chunk shows the two CXL host bridges without attached endpoints.
+
+::
+
+            {
+                "port":"port2",
+                "host":"pci0000:00",
+                "depth":1,
+                "nr_dports":2,
+                "dports":[
+                    {
+                        "dport":"0000:00:01.3",
+                        "alias":"device:55",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:00:07.1",
+                        "alias":"device:5d",
+                        "id":113
+                    }
+                ]
+            },
+            {
+                "port":"port4",
+                "host":"pci0000:2a",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:2a:01.1",
+                        "alias":"device:d0",
+                        "id":0
+                    }
+                ]
+            }
+        ],
+
+Next we have the `Root Decoders` belonging to :code:`root0`.  This root decoder
+applies the interleave across the downstream ports :code:`port1` and
+:code:`port3` - with a granularity of 256 bytes.
+
+This information is generated by the CXL driver reading the ACPI CEDT CMFWS.
+
+::
+
+        "decoders:root0":[
+            {
+                "decoder":"decoder0.0",
+                "resource":825975898112,
+                "size":274877906944,
+                "interleave_ways":2,
+                "interleave_granularity":256,
+                "max_available_extent":0,
+                "volatile_capable":true,
+                "nr_targets":2,
+                "targets":[
+                    {
+                        "target":"pci0000:a8",
+                        "alias":"ACPI0016:02",
+                        "position":1,
+                        "id":4
+                    },
+                    {
+                        "target":"pci0000:d2",
+                        "alias":"ACPI0016:00",
+                        "position":0,
+                        "id":5
+                    }
+                ],
+
+Finally we have the `Memory Region` associated with the `Root Decoder`
+:code:`decoder0.0`.  This region describes the overall interleave configuration
+of the interleave set.
+
+::
+
+                "regions:decoder0.0":[
+                    {
+                        "region":"region0",
+                        "resource":825975898112,
+                        "size":274877906944,
+                        "type":"ram",
+                        "interleave_ways":2,
+                        "interleave_granularity":256,
+                        "decode_state":"commit",
+                        "mappings":[
+                            {
+                                "position":1,
+                                "memdev":"mem1",
+                                "decoder":"decoder6.0"
+                            },
+                            {
+                                "position":0,
+                                "memdev":"mem0",
+                                "decoder":"decoder5.0"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ]
+    }
+  ]
diff --git a/Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst b/Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
new file mode 100644
index 000000000000..077dfaf8458d
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
@@ -0,0 +1,291 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Intra-Host-Bridge Interleave
+============================
+This cxl-cli configuration dump shows the following host configuration:
+
+* A single socket system with one CXL root
+* CXL Root has Four (4) CXL Host Bridges
+* One (1) CXL Host Bridges has two CXL Memory Expanders Attached
+* The Host bridge decoder is programmed to interleave across the expanders.
+
+This output is generated by :code:`cxl list -v` and describes the relationships
+between objects exposed in :code:`/sys/bus/cxl/devices/`.
+
+::
+
+  [
+    {
+        "bus":"root0",
+        "provider":"ACPI.CXL",
+        "nr_dports":4,
+        "dports":[
+            {
+                "dport":"pci0000:00",
+                "alias":"ACPI0016:01",
+                "id":0
+            },
+            {
+                "dport":"pci0000:a8",
+                "alias":"ACPI0016:02",
+                "id":4
+            },
+            {
+                "dport":"pci0000:2a",
+                "alias":"ACPI0016:03",
+                "id":1
+            },
+            {
+                "dport":"pci0000:d2",
+                "alias":"ACPI0016:00",
+                "id":5
+            }
+        ],
+
+This chunk shows the CXL "bus" (root0) has 4 downstream ports attached to CXL
+Host Bridges.  The `Root` can be considered the singular upstream port attached
+to the platform's memory controller - which routes memory requests to it.
+
+The `ports:root0` section lays out how each of these downstream ports are
+configured.  If a port is not configured (id's 0 and 1), they are omitted.
+
+::
+
+        "ports:root0":[
+            {
+                "port":"port1",
+                "host":"pci0000:d2",
+                "depth":1,
+                "nr_dports":3,
+                "dports":[
+                    {
+                        "dport":"0000:d2:01.1",
+                        "alias":"device:02",
+                        "id":0
+                    },
+                    {
+                        "dport":"0000:d2:01.3",
+                        "alias":"device:05",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:d2:07.1",
+                        "alias":"device:0d",
+                        "id":113
+                    }
+                ],
+
+This chunk shows the available downstream ports associated with the CXL Host
+Bridge :code:`port1`.  In this case, :code:`port1` has 3 available downstream
+ports: :code:`dport1`, :code:`dport2`, and :code:`dport113`..
+
+::
+
+                "endpoints:port1":[
+                    {
+                        "endpoint":"endpoint5",
+                        "host":"mem0",
+                        "parent_dport":"0000:d2:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem0",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:d3:00.0"
+                        },
+                        "decoders:endpoint5":[
+                            {
+                                "decoder":"decoder5.0",
+                                "resource":825975898112,
+                                "size":274877906944,
+                                "interleave_ways":2,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    },
+                    {
+                        "endpoint":"endpoint6",
+                        "host":"mem1",
+                        "parent_dport":"0000:d2:01.3,
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem1",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:a9:00.0"
+                        },
+                        "decoders:endpoint6":[
+                            {
+                                "decoder":"decoder6.0",
+                                "resource":825975898112,
+                                "size":274877906944,
+                                "interleave_ways":2,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+
+This chunk shows the endpoints attached to the host bridge :code:`port1`.
+
+:code:`endpoint5` contains a single configured decoder :code:`decoder5.0`
+which has the same interleave configuration memory region they belong to
+(show later).
+
+Next we have the decoders belonging to the host bridge:
+
+::
+
+                "decoders:port1":[
+                    {
+                        "decoder":"decoder1.0",
+                        "resource":825975898112,
+                        "size":274877906944,
+                        "interleave_ways":2,
+                        "interleave_granularity":256,
+                        "region":"region0",
+                        "nr_targets":2,
+                        "targets":[
+                            {
+                                "target":"0000:d2:01.1",
+                                "alias":"device:02",
+                                "position":0,
+                                "id":0
+                            },
+                            {
+                                "target":"0000:d2:01.3",
+                                "alias":"device:05",
+                                "position":1,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+Host Bridge :code:`port1` has a single decoder (:code:`decoder1.0`) with two
+targets: :code:`dport1` and :code:`dport3` - which are attached to
+:code:`endpoint5` and :code:`endpoint6` respectively.
+
+The host bridge decoder interleaves these devices at a 256 byte granularity.
+
+The next chunk shows the three CXL host bridges without attached endpoints.
+
+::
+
+            {
+                "port":"port2",
+                "host":"pci0000:00",
+                "depth":1,
+                "nr_dports":2,
+                "dports":[
+                    {
+                        "dport":"0000:00:01.3",
+                        "alias":"device:55",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:00:07.1",
+                        "alias":"device:5d",
+                        "id":113
+                    }
+                ]
+            },
+            {
+                "port":"port3",
+                "host":"pci0000:a8",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:a8:01.1",
+                        "alias":"device:c3",
+                        "id":0
+                    }
+                ],
+            },
+            {
+                "port":"port4",
+                "host":"pci0000:2a",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:2a:01.1",
+                        "alias":"device:d0",
+                        "id":0
+                    }
+                ]
+            }
+        ],
+
+Next we have the `Root Decoders` belonging to :code:`root0`.  This root decoder
+applies the interleave across the downstream ports :code:`port1` and
+:code:`port3` - with a granularity of 256 bytes.
+
+This information is generated by the CXL driver reading the ACPI CEDT CMFWS.
+
+::
+
+        "decoders:root0":[
+            {
+                "decoder":"decoder0.0",
+                "resource":825975898112,
+                "size":274877906944,
+                "interleave_ways":1,
+                "max_available_extent":0,
+                "volatile_capable":true,
+                "nr_targets":2,
+                "targets":[
+                    {
+                        "target":"pci0000:a8",
+                        "alias":"ACPI0016:02",
+                        "position":1,
+                        "id":4
+                    },
+                ],
+
+Finally we have the `Memory Region` associated with the `Root Decoder`
+:code:`decoder0.0`.  This region describes the overall interleave configuration
+of the interleave set.
+
+::
+
+                "regions:decoder0.0":[
+                    {
+                        "region":"region0",
+                        "resource":825975898112,
+                        "size":274877906944,
+                        "type":"ram",
+                        "interleave_ways":2,
+                        "interleave_granularity":256,
+                        "decode_state":"commit",
+                        "mappings":[
+                            {
+                                "position":1,
+                                "memdev":"mem1",
+                                "decoder":"decoder6.0"
+                            },
+                            {
+                                "position":0,
+                                "memdev":"mem0",
+                                "decoder":"decoder5.0"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ]
+    }
+  ]
diff --git a/Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst b/Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
new file mode 100644
index 000000000000..008f9053c630
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
@@ -0,0 +1,401 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Multi-Level Interleave
+======================
+This cxl-cli configuration dump shows the following host configuration:
+
+* A single socket system with one CXL root
+* CXL Root has Four (4) CXL Host Bridges
+* Two CXL Host Bridges have a two CXL Memory Expanders Attached each.
+* The CXL root is configured to interleave across the two host bridges.
+* Each host bridge with expanders interleaves across two endpoints.
+
+This output is generated by :code:`cxl list -v` and describes the relationships
+between objects exposed in :code:`/sys/bus/cxl/devices/`.
+
+::
+
+  [
+    {
+        "bus":"root0",
+        "provider":"ACPI.CXL",
+        "nr_dports":4,
+        "dports":[
+            {
+                "dport":"pci0000:00",
+                "alias":"ACPI0016:01",
+                "id":0
+            },
+            {
+                "dport":"pci0000:a8",
+                "alias":"ACPI0016:02",
+                "id":4
+            },
+            {
+                "dport":"pci0000:2a",
+                "alias":"ACPI0016:03",
+                "id":1
+            },
+            {
+                "dport":"pci0000:d2",
+                "alias":"ACPI0016:00",
+                "id":5
+            }
+        ],
+
+This chunk shows the CXL "bus" (root0) has 4 downstream ports attached to CXL
+Host Bridges.  The `Root` can be considered the singular upstream port attached
+to the platform's memory controller - which routes memory requests to it.
+
+The `ports:root0` section lays out how each of these downstream ports are
+configured.  If a port is not configured (id's 0 and 1), they are omitted.
+
+::
+
+        "ports:root0":[
+            {
+                "port":"port1",
+                "host":"pci0000:d2",
+                "depth":1,
+                "nr_dports":3,
+                "dports":[
+                    {
+                        "dport":"0000:d2:01.1",
+                        "alias":"device:02",
+                        "id":0
+                    },
+                    {
+                        "dport":"0000:d2:01.3",
+                        "alias":"device:05",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:d2:07.1",
+                        "alias":"device:0d",
+                        "id":113
+                    }
+                ],
+
+This chunk shows the available downstream ports associated with the CXL Host
+Bridge :code:`port1`.  In this case, :code:`port1` has 3 available downstream
+ports: :code:`dport0`, :code:`dport2`, and :code:`dport113`.
+
+::
+
+                "endpoints:port1":[
+                    {
+                        "endpoint":"endpoint5",
+                        "host":"mem0",
+                        "parent_dport":"0000:d2:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem0",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:d3:00.0"
+                        },
+                        "decoders:endpoint5":[
+                            {
+                                "decoder":"decoder5.0",
+                                "resource":825975898112,
+                                "size":549755813888,
+                                "interleave_ways":4,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    },
+                    {
+                        "endpoint":"endpoint6",
+                        "host":"mem1",
+                        "parent_dport":"0000:d2:01.3",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem1",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:d3:00.0"
+                        },
+                        "decoders:endpoint6":[
+                            {
+                                "decoder":"decoder6.0",
+                                "resource":825975898112,
+                                "size":549755813888,
+                                "interleave_ways":4,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+
+This chunk shows the endpoints attached to the host bridge :code:`port1`.
+
+:code:`endpoint5` contains a single configured decoder :code:`decoder5.0`
+which has the same interleave configuration as :code:`region0` (shown later).
+
+:code:`endpoint6` contains a single configured decoder :code:`decoder5.0`
+which has the same interleave configuration as :code:`region0` (shown later).
+
+Next we have the decoders belonging to the host bridge:
+
+::
+
+                "decoders:port1":[
+                    {
+                        "decoder":"decoder1.0",
+                        "resource":825975898112,
+                        "size":549755813888,
+                        "interleave_ways":2,
+                        "interleave_granularity":512,
+                        "region":"region0",
+                        "nr_targets":2,
+                        "targets":[
+                            {
+                                "target":"0000:d2:01.1",
+                                "alias":"device:02",
+                                "position":0,
+                                "id":0
+                            },
+                            {
+                                "target":"0000:d2:01.3",
+                                "alias":"device:05",
+                                "position":2,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+Host Bridge :code:`port1` has a single decoder (:code:`decoder1.0`), whose
+targets are :code:`dport0` and :code:`dport2` - which are attached to
+:code:`endpoint5` and :code:`endpoint6` respectively.
+
+The following chunk shows a similar configuration for Host Bridge :code:`port3`,
+the second host bridge with a memory device attached.
+
+::
+
+            {
+                "port":"port3",
+                "host":"pci0000:a8",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:a8:01.1",
+                        "alias":"device:c3",
+                        "id":0
+                    },
+                    {
+                        "dport":"0000:a8:01.3",
+                        "alias":"device:c5",
+                        "id":0
+                    }
+                ],
+                "endpoints:port3":[
+                    {
+                        "endpoint":"endpoint7",
+                        "host":"mem2",
+                        "parent_dport":"0000:a8:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem2",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:a9:00.0"
+                        },
+                        "decoders:endpoint7":[
+                            {
+                                "decoder":"decoder7.0",
+                                "resource":825975898112,
+                                "size":549755813888,
+                                "interleave_ways":4,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    },
+                    {
+                        "endpoint":"endpoint8",
+                        "host":"mem3",
+                        "parent_dport":"0000:a8:01.3",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem3",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:a9:00.0"
+                        },
+                        "decoders:endpoint8":[
+                            {
+                                "decoder":"decoder8.0",
+                                "resource":825975898112,
+                                "size":549755813888,
+                                "interleave_ways":4,
+                                "interleave_granularity":256,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+                "decoders:port3":[
+                    {
+                        "decoder":"decoder3.0",
+                        "resource":825975898112,
+                        "size":549755813888,
+                        "interleave_ways":2,
+                        "interleave_granularity":512,
+                        "region":"region0",
+                        "nr_targets":1,
+                        "targets":[
+                            {
+                                "target":"0000:a8:01.1",
+                                "alias":"device:c3",
+                                "position":1,
+                                "id":0
+                            },
+                            {
+                                "target":"0000:a8:01.3",
+                                "alias":"device:c5",
+                                "position":3,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+
+The next chunk shows the two CXL host bridges without attached endpoints.
+
+::
+
+            {
+                "port":"port2",
+                "host":"pci0000:00",
+                "depth":1,
+                "nr_dports":2,
+                "dports":[
+                    {
+                        "dport":"0000:00:01.3",
+                        "alias":"device:55",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:00:07.1",
+                        "alias":"device:5d",
+                        "id":113
+                    }
+                ]
+            },
+            {
+                "port":"port4",
+                "host":"pci0000:2a",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:2a:01.1",
+                        "alias":"device:d0",
+                        "id":0
+                    }
+                ]
+            }
+        ],
+
+Next we have the `Root Decoders` belonging to :code:`root0`.  This root decoder
+applies the interleave across the downstream ports :code:`port1` and
+:code:`port3` - with a granularity of 256 bytes.
+
+This information is generated by the CXL driver reading the ACPI CEDT CMFWS.
+
+::
+
+        "decoders:root0":[
+            {
+                "decoder":"decoder0.0",
+                "resource":825975898112,
+                "size":549755813888,
+                "interleave_ways":2,
+                "interleave_granularity":256,
+                "max_available_extent":0,
+                "volatile_capable":true,
+                "nr_targets":2,
+                "targets":[
+                    {
+                        "target":"pci0000:a8",
+                        "alias":"ACPI0016:02",
+                        "position":1,
+                        "id":4
+                    },
+                    {
+                        "target":"pci0000:d2",
+                        "alias":"ACPI0016:00",
+                        "position":0,
+                        "id":5
+                    }
+                ],
+
+Finally we have the `Memory Region` associated with the `Root Decoder`
+:code:`decoder0.0`.  This region describes the overall interleave configuration
+of the interleave set.  So we see there are a total of :code:`4` interleave
+targets across 4 endpoint decoders.
+
+::
+
+                "regions:decoder0.0":[
+                    {
+                        "region":"region0",
+                        "resource":825975898112,
+                        "size":549755813888,
+                        "type":"ram",
+                        "interleave_ways":4,
+                        "interleave_granularity":256,
+                        "decode_state":"commit",
+                        "mappings":[
+                            {
+                                "position":3,
+                                "memdev":"mem3",
+                                "decoder":"decoder8.0"
+                            },
+                            {
+                                "position":2,
+                                "memdev":"mem1",
+                                "decoder":"decoder6.0"
+                            }
+                            {
+                                "position":1,
+                                "memdev":"mem2",
+                                "decoder":"decoder7.0"
+                            },
+                            {
+                                "position":0,
+                                "memdev":"mem0",
+                                "decoder":"decoder5.0"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ]
+    }
+  ]
diff --git a/Documentation/driver-api/cxl/linux/example-configurations/single-device.rst b/Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
new file mode 100644
index 000000000000..5fd38eb0aaf4
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
@@ -0,0 +1,246 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Single Device
+=============
+This cxl-cli configuration dump shows the following host configuration:
+
+* A single socket system with one CXL root
+* CXL Root has Four (4) CXL Host Bridges
+* One CXL Host Bridges has a single CXL Memory Expander Attached
+* No interleave is present.
+
+This output is generated by :code:`cxl list -v` and describes the relationships
+between objects exposed in :code:`/sys/bus/cxl/devices/`.
+
+::
+
+  [
+    {
+        "bus":"root0",
+        "provider":"ACPI.CXL",
+        "nr_dports":4,
+        "dports":[
+            {
+                "dport":"pci0000:00",
+                "alias":"ACPI0016:01",
+                "id":0
+            },
+            {
+                "dport":"pci0000:a8",
+                "alias":"ACPI0016:02",
+                "id":4
+            },
+            {
+                "dport":"pci0000:2a",
+                "alias":"ACPI0016:03",
+                "id":1
+            },
+            {
+                "dport":"pci0000:d2",
+                "alias":"ACPI0016:00",
+                "id":5
+            }
+        ],
+
+This chunk shows the CXL "bus" (root0) has 4 downstream ports attached to CXL
+Host Bridges.  The `Root` can be considered the singular upstream port attached
+to the platform's memory controller - which routes memory requests to it.
+
+The `ports:root0` section lays out how each of these downstream ports are
+configured.  If a port is not configured (id's 0, 1, and 4), they are omitted.
+
+::
+
+        "ports:root0":[
+            {
+                "port":"port1",
+                "host":"pci0000:d2",
+                "depth":1,
+                "nr_dports":3,
+                "dports":[
+                    {
+                        "dport":"0000:d2:01.1",
+                        "alias":"device:02",
+                        "id":0
+                    },
+                    {
+                        "dport":"0000:d2:01.3",
+                        "alias":"device:05",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:d2:07.1",
+                        "alias":"device:0d",
+                        "id":113
+                    }
+                ],
+
+This chunk shows the available downstream ports associated with the CXL Host
+Bridge :code:`port1`.  In this case, :code:`port1` has 3 available downstream
+ports: :code:`dport1`, :code:`dport2`, and :code:`dport113`..
+
+::
+
+                "endpoints:port1":[
+                    {
+                        "endpoint":"endpoint5",
+                        "host":"mem0",
+                        "parent_dport":"0000:d2:01.1",
+                        "depth":2,
+                        "memdev":{
+                            "memdev":"mem0",
+                            "ram_size":137438953472,
+                            "serial":0,
+                            "numa_node":0,
+                            "host":"0000:d3:00.0"
+                        },
+                        "decoders:endpoint5":[
+                            {
+                                "decoder":"decoder5.0",
+                                "resource":825975898112,
+                                "size":137438953472,
+                                "interleave_ways":1,
+                                "region":"region0",
+                                "dpa_resource":0,
+                                "dpa_size":137438953472,
+                                "mode":"ram"
+                            }
+                        ]
+                    }
+                ],
+
+This chunk shows the endpoints attached to the host bridge :code:`port1`.
+
+:code:`endpoint5` contains a single configured decoder :code:`decoder5.0`
+which has the same interleave configuration as :code:`region0` (shown later).
+
+Next we have the decoders belonging to the host bridge:
+
+::
+
+                "decoders:port1":[
+                    {
+                        "decoder":"decoder1.0",
+                        "resource":825975898112,
+                        "size":137438953472,
+                        "interleave_ways":1,
+                        "region":"region0",
+                        "nr_targets":1,
+                        "targets":[
+                            {
+                                "target":"0000:d2:01.1",
+                                "alias":"device:02",
+                                "position":0,
+                                "id":0
+                            }
+                        ]
+                    }
+                ]
+            },
+
+Host Bridge :code:`port1` has a single decoder (:code:`decoder1.0`), whose only
+target is :code:`dport1` - which is attached to :code:`endpoint5`.
+
+The next chunk shows the three CXL host bridges without attached endpoints.
+
+::
+
+            {
+                "port":"port2",
+                "host":"pci0000:00",
+                "depth":1,
+                "nr_dports":2,
+                "dports":[
+                    {
+                        "dport":"0000:00:01.3",
+                        "alias":"device:55",
+                        "id":2
+                    },
+                    {
+                        "dport":"0000:00:07.1",
+                        "alias":"device:5d",
+                        "id":113
+                    }
+                ]
+            },
+            {
+                "port":"port3",
+                "host":"pci0000:a8",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:a8:01.1",
+                        "alias":"device:c3",
+                        "id":0
+                    }
+                ]
+            },
+            {
+                "port":"port4",
+                "host":"pci0000:2a",
+                "depth":1,
+                "nr_dports":1,
+                "dports":[
+                    {
+                        "dport":"0000:2a:01.1",
+                        "alias":"device:d0",
+                        "id":0
+                    }
+                ]
+            }
+        ],
+
+Next we have the `Root Decoders` belonging to :code:`root0`.  This root decoder
+is a pass-through decoder because :code:`interleave_ways` is set to :code:`1`.
+
+This information is generated by the CXL driver reading the ACPI CEDT CMFWS.
+
+::
+
+        "decoders:root0":[
+            {
+                "decoder":"decoder0.0",
+                "resource":825975898112,
+                "size":137438953472,
+                "interleave_ways":1,
+                "max_available_extent":0,
+                "volatile_capable":true,
+                "nr_targets":1,
+                "targets":[
+                    {
+                        "target":"pci0000:d2",
+                        "alias":"ACPI0016:00",
+                        "position":0,
+                        "id":5
+                    }
+                ],
+
+Finally we have the `Memory Region` associated with the `Root Decoder`
+:code:`decoder0.0`.  This region describes the discrete region associated
+with the lone device.
+
+::
+
+                "regions:decoder0.0":[
+                    {
+                        "region":"region0",
+                        "resource":825975898112,
+                        "size":137438953472,
+                        "type":"ram",
+                        "interleave_ways":1,
+                        "decode_state":"commit",
+                        "mappings":[
+                            {
+                                "position":0,
+                                "memdev":"mem0",
+                                "decoder":"decoder5.0"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ]
+    }
+  ]
-- 
2.49.0

