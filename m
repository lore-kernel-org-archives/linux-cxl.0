Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2C4AD7FE
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471278; cv=none; b=mFrL+A9LtVwGIFd9XEtwjZe7a6fW69NsXhyfzD7oZb0k7PjNH7ZFP4usmaYZUMUwfr9E8+GCFnQBUz1BfZ8mgKQqMj+2v/L6B4FeAUS3HXqnXg6iyUDiD7fMU1WiLJfoztuu4T4SLqeJxkVOpuvoaUGb+SjftOMWk+Wl8MKUxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471278; c=relaxed/simple;
	bh=qiCU60q1B8EF57ePBnwWQHsE/ozLtebvNq0cRDdn0S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roaTi4GCjjmyJcx130CECFp7NtISSIpnjXUzSz8BG7HszWqZx8HU3sUU99D+EtXsEqcR8LcsOanhQVAUvSpRReGQnzI41hBC4kmrwncQ24TnNJp6BFc3jjdJCkMsRDum1DAb5uYpz5twQR6thZiR7OEfW150lMd2+XF9S5hzy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tum9AKH7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tum9AKH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788471277; x=1820007277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qiCU60q1B8EF57ePBnwWQHsE/ozLtebvNq0cRDdn0S4=;
  b=Tum9AKH7iZrUtvXaLukrWOFZdZAi+uRRFAqQ4VxJbYbWl7EFzRQZREHW
   3YPcBAKZfl4QYW5wZXnMga9Izn7wt+4wCusQ+NnZYscoI2Vo3ncyy9Cyw
   70c59tHb4VG5TuIzk+6pOyeZzWmrLX7frC7xDKClTt9Sf1WHdAhaKjfKZ
   cIpD2l8Sp/Eyrn3C3K9lXj790V/PwE4aTtLWxfLRVRphpDG8uaBN2n7qm
   UAP//smg+sfuB/YmWrgBQih1HbItQiLi/8j/5udmQ3qJCfTzvGP8p/ETF
   lKMZNO4MCn8Z2BJeSZ9xmeUjVVnfoq4O4A7Xb4Yi6fV7VXO9Us6VinOVt
   g==;
X-CSE-ConnectionGUID: 7u1rthaWSUy1nUZKT3z8vw==
X-CSE-MsgGUID: lhLEnm/vRwKvOcM50tob2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76523236"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="76523236"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:34:35 -0700
X-CSE-ConnectionGUID: fuLM918WRDmAaWbxbpgc0A==
X-CSE-MsgGUID: IJSld3dzQo+M+hqFkJw59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="263657952"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:34:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH v2 2/3] cxl/region: allow mixed-granularity regions
Date: Thu,  3 Sep 2026 14:34:17 -0700
Message-ID: <12e71769a310979451734654e1aad6c4d5d4a2c9.1788469004.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788469004.git.alison.schofield@intel.com>
References: <cover.1788469004.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_region_determine_granularity() rejects any user-supplied granularity
that does not exactly match the root decoder's granularity, making it
impossible to create mixed-granularity regions from userspace even when the
kernel driver accepts them.

Relax the check to allow region_gran <= root_gran. This function only needs
to reject what it can determine on its own is always wrong - a region
granularity greater than the root decoder's. The kernel does the rest of
the validation.

Reject a granularity that is not a power of two, or is below 256, since the
previous exact-match test that screened those out implicitly is now gone.

Update the cxl-create-region man page to document the new behavior.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/cxl/cxl-create-region.txt | 21 ++++++++++++++++-----
 cxl/region.c                            | 25 +++++++++++++++++++------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
index b244af60b8a6..d5998ad725ee 100644
--- a/Documentation/cxl/cxl-create-region.txt
+++ b/Documentation/cxl/cxl-create-region.txt
@@ -93,11 +93,22 @@ include::bus-option.txt[]
 
 -g::
 --granularity=::
-	The interleave granularity for the new region. Must match the selected
-	root decoder's (if provided) granularity. If the root decoder is
-	interleaved across more than one host-bridge then this value must match
-	that granularity. Otherwise, for non-interleaved decode windows, any
-	granularity can be specified as long as all devices support that setting.
+	The interleave granularity for the new region. A granularity coarser
+	than the root decoder's is never legal. If the root decoder is
+	interleaved across more than one host bridge, then for a given number
+	of ways at most two granularities are legal:
+
+	  * "root_ways * root_granularity / ways", which creates a
+	    mixed-granularity region. The root interleaves at its own coarser
+	    granularity and the levels below it, host bridges and switches,
+	    interleave at the finer region granularity.
+	  * The root decoder granularity itself, which repeats the root
+	    interleave pattern across a wider region. This is available only
+	    when the root decoder ways are a power of two.
+
+	The two coincide when the region ways equal the root decoder ways. For
+	non-interleaved root decoders, any granularity can be specified as
+	long as all devices support that setting.
 
 -d::
 --decoder=::
diff --git a/cxl/region.c b/cxl/region.c
index 9d727216b9b8..de9f487ddff9 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -620,6 +620,18 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
 	if (!p->granularity)
 		return granularity;
 
+	/*
+	 * The CXL specification defines interleave granularities of 256 through
+	 * 16K in powers of two. Reject anything else here, rather than leave the
+	 * user with a bare EINVAL from the kernel.
+	 */
+	if (p->granularity < 256 || !is_power_of_2(p->granularity)) {
+		log_err(&rl,
+			"%s: granularity (%d) must be a power of 2, 256 or greater\n",
+			devname, p->granularity);
+		return -EINVAL;
+	}
+
 	ways = cxl_decoder_get_interleave_ways(p->root_decoder);
 	if (ways == 0 || ways == -1) {
 		log_err(&rl, "%s: unable to determine root decoder ways\n",
@@ -632,15 +644,16 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
 		return p->granularity;
 
 	/*
-	 * For ways > 1, only allow the same granularity as the selected
-	 * root decoder
+	 * For ways > 1, allow any region granularity up to and including the
+	 * root decoder granularity. A finer region granularity produces a
+	 * mixed-granularity configuration and a coarser one is always invalid.
 	 */
-	if (p->granularity == granularity)
-		return granularity;
+	if (p->granularity <= granularity)
+		return p->granularity;
 
 	log_err(&rl,
-		"%s: For an x%d root, only root decoder granularity (%d) permitted\n",
-		devname, ways, granularity);
+		"%s: region granularity (%d) cannot exceed root decoder granularity (%d)\n",
+		devname, p->granularity, granularity);
 	return -EINVAL;
 }
 
-- 
2.37.3

