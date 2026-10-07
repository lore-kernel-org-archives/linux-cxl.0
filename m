Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208583CB2FD
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404332; cv=none; b=dMq8xXbNCL+Yj+nieFflF0ck++WLH3omCi+uHhEkVjVCpFsaFp3t3+VHDL2XYOkdyTw5CF10mg0fasGcbyGB+aJWT9oYuqdLAbWaku2p5huFARHoCJ2qYM+slHDovt8TCemSCuOG9Yg9EK8tEc9NrENTCWB+cRRoiaj3jKRL528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404332; c=relaxed/simple;
	bh=OKaeIO9X1hiHfV6TzafdOqaB7v65zFl5igFThBWqezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddTF8lUOnr7doUUqW4wr577BBoZCKgv9UPe7iUIvG95mrZTDNBRtxxbSNxEV7zo0JWbGiANN8u91F9p93cSI/SbpGheRav9FIltsRMVCB10Rbn6gyzn+q7FRsOdTTaxhvRexIRD70blcqm00412gAaNicsr1qfZOajXreFqzaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rz1IuJpB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz1IuJpB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a813079a55so12441a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404328; x=1792009128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5pSlynuMJzfUhbXx8QpV8TphfLEgYQox+MdVfDxaBE=;
        b=rz1IuJpByAF7JbrPm3qBDuLPonSNcy+nsC6s7lEguRzKO9MJdfe/O0EVdI105iwkKF
         dmVSCfVEXyIS8KuINsUre2Z5DheBAEthQznJ1/PalBOog828NgWkopsnCgSmnpn0UIth
         isp79eSKZmNpPESp0c3wUqgjRoiGJoBVozvnvMImqiIjE3zVJkFa5HzIy9+4DTN+OnMS
         d7zYTZCOEo4wsSSjciVVh66wS739In20m/KHaaByNBCK2qvo24+padEE39VASbUMCkDx
         2MxqEkx3SBdm22Lytw36vikbwCRId3b4hv8J1lcbnqAZ8At2+Facv15mJ+mckqfxKEFK
         7EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404328; x=1792009128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5pSlynuMJzfUhbXx8QpV8TphfLEgYQox+MdVfDxaBE=;
        b=KhtNUCIEnLLHmw9JEGuyB2FCw4JskolDEqBOGFTg+sv02HAPnwQnADf2qQhWP56MDH
         +68WmVNLhzd5MgzKIrbECOdTCkgB+3cX5+u1YSkKU3IKxvuCN2TPRBIcSniGm48hI0p2
         zSqS9zZckypJ5RbsqkxOlcUrDD7Lkyez+E5TsCFp0ldklCZV1EcmDSGU/yruYy4h9Lb1
         C80q0gUGp2R0qO1vOZsiNPVP4zXOTqAazx4WCmzbUekLQFhCkCw8Qphj7ifzds3f48G9
         Yw1/juNl8iGh8cEpUUeaorZTcOMNqDkwAPUng7DB8/Nwo3Ewp9UZdNXrNp92H4WNW7gs
         li6g==
X-Gm-Message-State: AFq9FYIhexP5nkWxqX4d9R5ijvQv7YIKLJSW065DTz+6m+rqgfEYvGKw
	tyZl9ikAlAojvqozZr2utPzIBVZCtHSMLE3Egihm2D3iHjMQ/WGFCWmKqmAj2g==
X-Gm-Gg: AYBFou0FpyMw/sPxo6h4MgcBBJnyChWHmGVxQQ4NyiaTuIWPSrsOvRIwn3b3nUKlB86
	bmn5xblxiHYM6ikqpvdPaF/lmSMisjygYfBPq1RqTVV+YEU/GIFZDr+xRptTXEY7rHAEvBJAa8S
	y2aJXKMgiiN6/VIgbX9LfB9xzcOSx5sLmRcsQh6qXSkQHqUE+Z8Nc05vy0DUgYSf8GbYLI3xgIW
	qdV9EVxDdjku+GCJaJKK8CJ4DDBh+V0OrS/Xgr2t6AUGAvl6niTx3BAiGosL0SVvseQ3B6RQDrV
	wxes7C8EYU/NU5EoejRJOVm8YPQTjUrbYw1DCnZipuX2TwYyrGg2BX+t+8iGKBJirrcm3boLosD
	V2cCkjmccCjo52ImZJw0yD5h5OlMkp5+kBpE6IB9zqdI8fYIzBezMnV2h0iKRWmZU6wXEba6oVZ
	T1VCqad7IS1abjUR09mttt+ZGRmyfZphVqyF6zle059UfvZZIyFXPU4QUdbWqMcM7xH6vJimUQN
	+WR3D0EWC/SGS9HphqWwhmtFNIIQY8J2Bdi+abFsEzNq5okaZospTQUcLhFVGWrWOoVDJx8qCL4
	C3kk4LPajcaNLA==
X-Received: by 2002:a17:90b:6cc:b0:3a7:ed4d:afeb with SMTP id 98e67ed59e1d1-3aaed7ff677mr143101a91.27.1791404328364;
        Wed, 07 Oct 2026 13:18:48 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm967623a91.4.2026.10.07.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:18:47 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v15 8/8] Documentation/cxl: Document DPA partition layout and ordering rules
Date: Wed,  7 Oct 2026 13:16:41 -0700
Message-ID: <20261007201828.952-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007201828.952-1-anisa.su@samsung.com>
References: <20261007201828.952-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DC Partitions complicate DPA ordering. Add a DPA Partitions section to
cxl-driver.rst describing spec-mandated and Linux requirements for the
layout.

maturity-map.rst breaks the DCD entry into sub-items so the map shows
what this series lands: partition enumeration is [1], event handling
and DC-backed DAX regions remain [0] until the follow-on series enables
them. The parent stays [0]; nothing is usable yet.

Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
 Documentation/driver-api/cxl/maturity-map.rst |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..212df4fb8d63 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -181,6 +181,41 @@ A Memory Device is a discrete base object that is not a port.  While the
 physical device it belongs to may also host an `endpoint`, the relationship
 between an `endpoint` and a `memdev` is not captured in sysfs.
 
+DPA Partitions
+~~~~~~~~~~~~~~
+A memory device presents its capacity as one flat `Device Physical Address`
+(DPA) space divided into `partitions`, which Linux lays out in a fixed
+order::
+
+  DPA 0                                                     end
+  +---------------+---------------+---------------------------+
+  |      ram      |     pmem      |       dynamic_ram_1       |
+  +---------------+---------------+---------------------------+
+  part[0]         part[1]         part[2]
+
+Part of that order is required by the CXL specification and part of it is a
+Linux choice.
+
+The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
+Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
+at DPA 0 and pmem starts at the DPA immediately following it.
+
+Dynamic Capacity partitions only need to be 256MB aligned according to
+CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
+(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
+(static) capacity and its first DC partition, or between one DC partition
+and the next.
+
+Linux chooses not to support gaps between static and dynamic capacity: the
+first DC partition must begin at the DPA immediately following static
+capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
+a device with no static capacity at all.
+
+Currently, only one dynamic partition is supported. A device may report up
+to eight (CXL r4.0 Table 8-346); Linux configures the first as its
+`dynamic_ram_1` partition. Gaps between DC partitions are not checked, since
+only the first is used.
+
 Port Relationships
 ~~~~~~~~~~~~~~~~~~
 In our example described above, there are four host bridges attached to the
diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..fefd31899229 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -150,6 +150,10 @@ Memory-pooling
 * [1] Hotplug of LDs (via PCI hotplug)
 * [0] Dynamic Capacity Device (DCD) Support
 
+  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
+  * [0] Extent add / release event handling
+  * [0] DC-backed DAX regions
+
 Multi-host sharing
 ------------------
 
-- 
2.43.0

