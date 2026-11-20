Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196089;
	b=vnyexLVSbr18MqUWM1NPfcy6UQ6y13g89GaPckHXN1B2DehpYYLvplE9yFj4VAO4C7i7
	 8u7dxMs7isw4h9gRmee3dhLxNxxQLhLpRdlZMZ4QIXYD2N3UrCsjkaHNrsCmMiOE2qqtG
	 F1Mv7shl6RZkgBDeLSUF+CoS5Q5tIv2SBCJXJuq/6SbR9JNaWz5r/zoJR9FmRYuIrqF+D
	 XgfQdhD7sd9IuUXZyfbx554bpmS392WMDrcHCQhb8emzI0+bPl0fnJwM4AlxZ8qo2QN9F
	 dd5eR3COEhiQTqgIodanmDu34o11UTt4kcehzs1coMofMmN1eUGN1ndciQmYkqilpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196089;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Content-Language:To:Cc:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=IJSoYfDGNElU2HGzFeCIxk25wKCRD+genvhBATiMOo0=;
	b=TIOglbMUwa3J41iNYBO6oM4n8evTjNruHOEujNnUbh4o1k1ksLoYhmcIKIXXK7FdkwvY
	 cuPJcqm00wcuiMK9HpBFW7LLVQIXIlDsH+xazJ1dnZTS70pq4AJdC+8crEvy+2J/9319q
	 NyDKtx35T5T5RnmXE3fizGhbx2xyW9EIiEh2i21xEbblzZp0OvJSZQJQxlKx/IWOezSXI
	 1qC7pcDiLWtJ88YCiAAwOTtOZWfd1WedXBeie0niwbGdWJgTElowzMPqU9eCecdrSCqgI
	 JSWzm41IKwDbdt3M+l8mJNlQ3+yZfA1YbaXXb1k91I6zITPKmiCQZM7T7bXIS5PuVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SbgitGF/";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2246606A32A;
	Fri, 20 Nov 2026 17:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2246606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SbgitGF/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795196088; x=1826732088;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=tVIl1oy/CboezVgy3jBsegn6rNWOcKOdQzuPeDENzoM=;
  b=SbgitGF/iT6IekcXrApIhHi5oZEucUKgys2wJ2frx+/uWPXVtXoEzci1
   aPCg791pNyu6otvmNKns8oonCgby0vUDGs/5n8QBQm3sgpY2x22Wd4wz4
   YJtAIKK8fQSJ+0aFZKldMTR2v3GKEpUGOfeS//5IAZcQvqHBp9l2msURw
   A6hygmOFlgb8yKT+mnlwiqpXHmdirdP1EoSUi4y75gvhZyFaCRSfwKruD
   XKl5MVcoeRCOdRsU+YFdIO1Fc0IOtnFxMR7rK2qey/ZhNzZMBbGZfGG7T
   fIwTdpGAHAYqiHGyOy//FUhm3BNXJqfKJRpsRWtnquBAGAXHReSxiQY6J
   w==;
X-CSE-ConnectionGUID: Y3aj2JqpTvSHnPZZVIpcxQ==
X-CSE-MsgGUID: bl73grPvQ6inXnlC+I5lkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3962504"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3962504"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:34:47 -0800
X-CSE-ConnectionGUID: 9YT1AebQQ4WvpXnE14ZqNg==
X-CSE-MsgGUID: im+REL5qScq/4oV8ZIehrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10561234"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:34:46 -0800
Message-ID: <c2b42261-71e8-46c1-b847-16b12ee81676@intel.com>
Date: Fri, 20 Nov 2026 10:34:45 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 7.4-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.4-rc4

...to receive a small collection of CXL fixes. These have all appeared in -next
for a few days with no reported issues.

---

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.4-rc4

for you to fetch changes up to a02576de05178f15ffe6fc7551496de7de8acfde:

  cxl/port: Fix endpoint RAS error unmasking (2026-11-17 15:37:49 -0700)

----------------------------------------------------------------
cxl fixes for v7.4-rc4

cxl/port: Fix endpoint RAS error unmasking
cxl/test: Free the decoder registry when cxl_test_init() fails
cxl/region: Reject a repeat write of an endpoint decoder to targetN
cxl/region: Restore a target's position from its slot after sorting

----------------------------------------------------------------
Alison Schofield (2):
      cxl/region: Reject a repeat write of an endpoint decoder to targetN
      cxl/test: Free the decoder registry when cxl_test_init() fails

Davidlohr Bueso (1):
      cxl/region: Restore a target's position from its slot after sorting

Richard Cheng (1):
      cxl/port: Fix endpoint RAS error unmasking

 drivers/cxl/core/region.c    | 11 ++++++++---
 drivers/cxl/port.c           | 16 +++++++++-------
 tools/testing/cxl/test/cxl.c | 24 +++++++++++++-----------
 3 files changed, 30 insertions(+), 21 deletions(-)
