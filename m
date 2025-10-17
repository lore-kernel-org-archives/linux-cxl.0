Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960E322DC1
	for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681490; cv=none; b=FBKiOVw20Jdxd7SuzcNkCjqzL/UudSlTwfhR6kYbpTdO+bIGJjnn3Kkhlte5uadRUpq66WwIUcU5h3l8jFrG080sZwTflNUYpOIKV6NBGIZq+le4suoOIHGXZx1PZlWXh/zpo090TM0OxV0eS1uKgfbm5nXmihAb3xIRhY0yV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681490; c=relaxed/simple;
	bh=tikMEle/G/GkBijlPwu+3b7d1w+RJh81JR7+Jsyvuqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpdjeVHMOQVvpmSKL7b3a8ejX+9AgiDw8lc5rN1VUpu5m6ysQPm4g+S3tNhPR/JFNZisodY3WBIW+U7KIsjWB9Uv617y6HEcd+S85P3smV0NTVAqm2N3eN0qPcMIGSJ05iYWNqG3y7xaLYDmyVQuaLQ73VhNx9YHkbKe+oQq6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wtacB6tF; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wtacB6tF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760681479; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=AK572BdDRYMHWa5xjSSc+Cuv4nNXEjxPZUtK6w6ic8E=;
	b=wtacB6tF1cFSyjeOpVtuW4x/B7fW1kMfJKWa4C/vfg8/ElM6ljJgjyD71kFAMTcF9cYvUPR6ORQPSCKctz5sQOUVQp7wu6dW1DQAS3NiEFBQFpymHOFQ8/x6kMnk2fG0N4b16fZIxYrcgt7Th+426GI1jaXtBIyVjlnM66QG3Zg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqOlvx1_1760681478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 14:11:18 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
 <dave.jiang@intel.com>, <alison.schofield@intel.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <seven.yi.lee@gmail.com>, <hch@infradead.org>, <a.manzanares@samsung.com>,
 <fan.ni@samsung.com>
Cc: <linux-cxl@vger.kernel.org>
Subject: Deep flush support for CXL pmem?
Date: Fri, 17 Oct 2025 14:11:16 +0800
Message-ID: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, All,

When reading the documentation of PMDK (https://github.com/pmem/pmdk), I
found that deep flush is used for data loss recovery in addition to GPF.
With that, we can identify that a file isn't affected by the GPF failure
because it wasn't opened during the GPF failure.

However, IIUC, the Linux kernel doesn't support deep flush (via
nvdimm_flush()) for CXL pmem at least for now.  For NVDIMM, we have WPQ,
but it appears that we don't have that for CXL.  Is deep flush for CXL
defined in some spec?

---
Best Regards,
Huang, Ying
