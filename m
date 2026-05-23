Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A7346AD6
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529855; cv=none; b=nzEA69LWmxDnjy/htqdtReqS1hwjEVBaGUo5/G7iWxc1XyfZ6ooNma3izDOhWbyAnsl6PP6siYg2NB2BYtfhoudwwIGo/DxusMFJGdyrVYHR0EREQE/AB9XyhAWzsCn4njHTvZasFwcpacoKUAca3nfhT2p3fEJ4tgZF/IZ+QHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529855; c=relaxed/simple;
	bh=tV9eVPzA4alBVC2GhOgYHNOWGjBFnMKU4PywOkoIUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+tKPebjmq4HOW160J9zal55nVbtnIPqag12/tRfYUW5UFxWHz0MgzQYvJlFgMRv5WhC3bVZpjesgmPcnrKSV3C4SZLThg+4hDmov59+/TZZYyjdhn3uLoO9WbSbxsu3W9+zY/g/+tPlxXDWpwzr1pjqXo/JFazCAOqNUL/z9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQg/QpOG; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQg/QpOG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3045c195251so976528eec.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529853; x=1780134653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwPUwyjbFgIHmeBuVl0MOj2c+NoiA0doE1ZNsHpwIe8=;
        b=LQg/QpOGxfZpK8grzrTUiegbpFyj/oqKVP23x9l5q9MnKOKEdFLYs1bgumIZpXFEaq
         Gh5vI+EHu9GB+NBWJQsPcSHCDtiJvxTLa9gC0M4CvguWp3+P0G1K+dgkWXsfIlSX3Qpa
         lbGA7lPJTEMkFu2kvy7vntoqR6lpiTtVm51SyOafEmXaf5CvEBJ1bICZSdS9wminLhZU
         QmrXr9uGE0spPHjjLeLN+eLfpW4majJPF5WUrf9F3UjRcEHSEmSj2HP/NPP1yGvB/Vku
         MXjJmeNNx1SqLT4Gsjn+UTICHdHdeqAMbAXt93lkU2u1EeFrFWDgWiIPnrrGf44Uzrom
         PxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529853; x=1780134653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MwPUwyjbFgIHmeBuVl0MOj2c+NoiA0doE1ZNsHpwIe8=;
        b=CA6QUreCkVFTwOuxfWCLATZGYUVWj1oGfZFImZUpopC+deMz3VptS3uqF64f+ZZ8a0
         yPkr57trg1FLzOrq6sPTwZRCCJDgCpHrXfmzn13H7sXVWDqICLDE/pIPvQfWh2Khmoho
         0c+9mUbf1HFG4gENKnfzDWFBCoLHSarD4KVwirNZr82ZGVAvsi73P4vLo4zBnAVKQBIP
         gqA5N3b/22h9bbfWfNZhNkoDrcN+wEUCsreZBK5Gc3YWMSt8VjEWnY+NukVd2DG3ni+2
         rGauMlMX3MBntnV0aN1z58BbHJ/f7+Ot9tueyHQO7yS0zJsrrafyKTK8yTVTgwX6JamB
         toCw==
X-Gm-Message-State: AOJu0YxDFPZxr/TNTh2hN0P4EkCMSzUDim+dZNJe3ajg7G6fRQr0KtVp
	wLpGq2haUI5TTfprBoxsk8yuMOcqzhDfoKTE1WmkJoDbCVu4sBWAtt32K6tBkA==
X-Gm-Gg: Acq92OHAAPS4d3lLUkhJZLC8SGkVFZ0YSpC0cFhEqvtFeXPcBf6VuW796fuEkbK/j2r
	AxMsue0lxSN4XLGpOghWPe/6bXH6gpg3XhvMtJODAruJBmO9zYx7yLd6RVFvdK77Whn/MwU/xU3
	RLWyoagGXGKVm0LW/IFtR7xogeMix7y6js5I5N6eQ1KFzKbVleiOm1W0ucYO3QkjlK2DB6eR3Em
	3cfPHcwQyKTkCx0d7TTEi0rqKw/sNJFYWhDpJAq6piVKSp3m94aU1oToJx83B6YQbWVzAd3BGlK
	23xbbQtxDHV8G1534X6RX8HMi462drQo/mz6D3nR04Ipjz+aW8lviaa4gLHNyIQtUYGBRHfjRwA
	gzjybFGEGLh7ig3i36VO+7eQpA97uGGVjFuhLsqFo2ruOwj+5PhqaWDnLQzZCq9xIG4txXYW4rR
	r+Wq1qNSpr9ZulAWCLt4DAyuxC/Y3gfOr+ite8a8RmKKNCVjY/U+HKUnxp5FnLI4OB/lyi8oc1y
	enYuXLmV9WWvJrBzA==
X-Received: by 2002:a05:7301:ea3:b0:304:2e9b:8f56 with SMTP id 5a478bee46e88-30449144693mr2991479eec.31.1779529852750;
        Sat, 23 May 2026 02:50:52 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045225b7b6sm4595756eec.25.2026.05.23.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:50:52 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>,
	"Jonathan Cameron" <jonathan.cameron@Huawei.com>,
	"Fan Ni" <fan.ni@samsung.com>,
	"Sushant1 Kumar" <sushant1.kumar@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v6 1/7] ndctl: Dynamic Capacity additions for cxl-cli
Date: Sat, 23 May 2026 02:50:36 -0700
Message-ID: <20260523095043.471098-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523095043.471098-1-anisa.su@samsung.com>
References: <20260523095043.471098-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

This series can be found here:

	https://github.com/weiny2/ndctl/tree/dcd-region3-2025-04-13

CXL Dynamic Capacity Device (DCD) support is being discussed in the
upstream kernel.  cxl-cli requires modifications to interact with those
devices.

A new partition type 'dynamic_ram_a' has been added which cxl-cli
needs to know about.  Add support for the new decoder type.

With DCD regions may, or may not, have capacity.  The capacity is
communicated via extents.  Add region extent query capabilities.

Add cxl-test support.  cxl-testing allows for quick regression testing
as well as helping to design the cxl-cli interfaces.


To: "Alison Schofield" <alison.schofield@intel.com>
Cc: "Vishal Verma" <vishal.l.verma@intel.com>
Cc: "Jonathan Cameron" <jonathan.cameron@Huawei.com>
Cc: "Fan Ni" <fan.ni@samsung.com>
Cc: "Sushant1 Kumar" <sushant1.kumar@intel.com>
Cc: "Dan Williams" <dan.j.williams@intel.com>
Cc: "Dave Jiang" <dave.jiang@intel.com>
Cc: <linux-cxl@vger.kernel.org>
Cc: <nvdimm@lists.linux.dev>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes in v5:
- iweiny: Adjust all code to view only the dynamic RAM A partition
- Alison: s/tag/uuid/ in region query extent output
- Link to v4: https://patch.msgid.link/20241214-dcd-region2-v4-0-36550a97f8e2@intel.com

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 5,
    "change-id": "20241030-dcd-region2-2d0149eb8efd",
    "prefixes": [],
    "history": {
      "v1": [
        "20241030-dcd-region2-v1-0-04600ba2b48e@intel.com"
      ],
      "v2": [
        "20241104-dcd-region2-v2-0-be057b479eeb@intel.com"
      ],
      "v3": [
        "20241115-dcd-region2-v3-0-585d480ccdab@intel.com"
      ],
      "v4": [
        "20241214-dcd-region2-v4-0-36550a97f8e2@intel.com"
      ]
    }
  }
}
-- 
2.43.0

