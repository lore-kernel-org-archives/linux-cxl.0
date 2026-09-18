Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C8311592
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763508; cv=none; b=sU2pTqBnNXG59cYpTYhzuGGe/koXQmLw4Y0BzjRja1U6+tuPb9cigJpCH1wtLWWwKZCpw0HLOr75lWk1n6qjPOL3iM4s8tqovky3lVrzeYmXTfeX2p3oWyY1gycM/gr7YZx9QUQYO25U8YqhyY1jsO1qUuMJHBGAJhFTHZTyaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763508; c=relaxed/simple;
	bh=OpJxiFKNWXG9NMjTSVgXV4WvZ+CLCYHbO3ndvmMh7Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlNlgeZjyTxjnO0Zy5nbcTHIRUZDBVaUSSAVjznKuITgOb5wAAnJDxh+wCBnSrbH1MEkYrhd8+pptxPyNq/9DW8qZ6qupvCSpIuNqwna5aYDIK/r3wHiq8slfKpka0hGSrA9nRiwbNkwKAnElSBXeZSQZuZfUaNnw5EG96X71VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd2VYXYg; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd2VYXYg"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7f72a284so1144845d50.2
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763504; x=1790368304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQ2Blnb8c8l0sThzBpYfoW7Dht8/+zEXOpb6N3rkEs4=;
        b=kd2VYXYgpoz0yuFY8XTDtlPyDfXFWQRigwmqFKXkni874A4QvW4mn0TT/1eDIR7aob
         rtKFkTSMMDTHNFR6RkyVPLiAVeR37JQn8owjnC1WIchnAGKZVsfPBM+EThLhaRx+P9fk
         1sfX9bm3axthadmLFler6gKM4T7vFfZKoO+CHUXK3oqDyzaeLk51FrdX7nd9jarUXhsm
         iyJjH34EeB2SuSu3Xd20f7l9gBYjcub7MKg9WLRndiQcyLGl2+g5If22c6O+jeFUd1uF
         dx6Qp/MqoQ//Qi0/+dzKfkv6k+bJ0OHyaFCg8EbEgyw3RqpPwQJDHJInZGUQ8wwiEudd
         CIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763504; x=1790368304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQ2Blnb8c8l0sThzBpYfoW7Dht8/+zEXOpb6N3rkEs4=;
        b=GqkANN17pqBaPNPPZD6KSpZoCAg+iZ9TUK/o4h6LQp9j1Xzlzn4JXUytcWY7WtCPiS
         y9aSJQtcVXpovvVa+YlQD+/PrW0kX8TMA9ftUq3eKV55XppMW+u2DPyp7o5Y/jbMWR6u
         0jA+s6xEDRqF/YRcW2qCHEt2cqyKTslep9XDQgHoJEP4IXcX7szd3ZxpK82k5loU0w8B
         wwOOSGWTXJBBThDzhaZO1ZYq3/+zkDfxvRit76Lof7xpYkQCI6iB0I/66LGNaqeYK0Yu
         t3s+SNv8q7E4sGr5mU4o0VWyTENBIgLShyNNXzZOl1TAdNckf8CF/reLb0vs6izsslGq
         7qWg==
X-Gm-Message-State: AFuF++nYDi0dwTpAPnoZ09Yk2mTjIAYfoRQbvxqFejCTX/HAEKpLeoMs
	Lnn6qrXkNvY08rj+h9f1+kIB3f43Qdkq2FPQXorNYLIRcnBwm6CrHTRrDxNx6w==
X-Gm-Gg: AYBFou370ykTGtyT0Jnp7f4s/olRxWzi34pf2oIQbqwaee0vkQwMPAU6D468sCVKE9f
	/6MfeGG1hJsOIpxM5vKUORIz396DHqN5Ug0DvLO12qxdVLyssaoOTQN5tKIQjwbFotDoMuMDxhl
	u18CeDOMBrKsdWOJG2jhuWxs3c3cCx/XpnytKXqWJYliblddTdJkOKoTIJiNCQHBzbqYTSKklUO
	4oXgOKnK8rKkGBBHy+AQ2aun6x81/U9iNfJRsWH8W0brstqhJfkPJ0+CcXOgfnn7Flws0Uvrep4
	Utul/GCzIIjAodTEAHH+9onTMg8tiR0YJnIcA83mywEIPqb4j/bpIpviqmMdrtFboHmGHOvuKOU
	n4dry0/V1ugjqb//NckDcFEZLLad0LksX3g2m/FVACZxLLtwQXCMTjcfzobyMK94Vt9fR0S+qJ8
	PNWFh23KMIHvHFPnah+fctZ6+ikFov1qsvo6utxO50u1Mlr1gPwW4ypZ612ztSmyAXnsSOKpx8K
	uxpq2sGLq+UQmVw581U1XH2dNd8FTQbLDwfdwPz0tju98ii3Q==
X-Received: by 2002:a05:690e:80a:20b0:671:3ae7:5214 with SMTP id 956f58d0204a3-6717fdf74c0mr895692d50.81.1789763503654;
        Fri, 18 Sep 2026 13:31:43 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:43 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v14 8/8] Documentation/cxl: Document DPA partition layout and ordering rules
Date: Fri, 18 Sep 2026 13:30:17 -0700
Message-ID: <20260918203049.7273-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918203049.7273-1-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
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
Changes:
[jonathan]: drop paragraph describing "support for additional
dc partitions may be added later..." to avoid predicting future work in
documentation
[davidlohr]: add DCD sub-items to maturity-map.rst so a multi-step
upstreaming shows users what is there and sets expectations.
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
 Documentation/driver-api/cxl/maturity-map.rst |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..eb4de2a9a9af 100644
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
+to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
+`dynamic_ram_1`. Gaps between DC partitions are not checked, since only the
+first is used.
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

