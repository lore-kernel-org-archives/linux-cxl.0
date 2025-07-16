Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876B27602B
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663748; cv=none; b=rlnHFFvtIPdQHQE7aFLwdvddjMvX5/ew+zMHrfYz+/DUatfZJ6kcugkpf34yryKj7MvZ9yjZhapGkIB1lcO9nGf0+IAwvOLTMJGQyNaHtXcKclSqP9KHx9dtBfrQAY2+M00w0Z1/RocxZHWiFcFPm0rlhuKTW4RJHWgAlNQqNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663748; c=relaxed/simple;
	bh=+34qnybU24wYd7owSLDQrd9mDdhdgXL4LKsrjH88Zlg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeW6z5U60Fmy6rBp0CHxklrTr4+em65WGF/ZGzFGVrMZmnN7Igwg/scPEpJ8hQhRbydGNSmaa+C/9+aMfWdcFV6+RmdCwNUzDuNDm5Gv+tWs6K/QhyS97YSxLixToE3ItRNoT6vjDopaz+R3q+q6Kj86+UYpuvr7p0+nmSDOqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtMt2Blkz6L55l;
	Wed, 16 Jul 2025 18:58:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BAF3A14010C;
	Wed, 16 Jul 2025 19:02:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 13:02:22 +0200
Date: Wed, 16 Jul 2025 12:02:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] cxl/region: Add inject and clear poison by
 region offset
Message-ID: <20250716120220.00007f20@huawei.com>
In-Reply-To: <612f019902bfb63ab22d7c4cf0f2f52fbc3ba5b8.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
	<612f019902bfb63ab22d7c4cf0f2f52fbc3ba5b8.1752365427.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 12 Jul 2025 19:37:57 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add CXL region debugfs attributes to inject and clear poison based
> on an offset into the region. These new interfaces allow users to
> operate on poison at the region level without needing to resolve
> Device Physical Addresses (DPA) or target individual memdevs.
> 
> The implementation uses a new helper, region_offset_to_dpa_result()
> that applies decoder interleave logic, including XOR-based address
> decoding when applicable. Note that XOR decodes rely on driver
> internal xormaps which are not exposed to userspace. So, this support
> is not only a simplification of poison operations that could be done
> using existing per memdev operations, but also it enables this
> functionality for XOR interleaved regions for the first time.
> 
> New debugfs attributes are added in /sys/kernel/debug/cxl/regionX/:
> inject_poison and clear_poison. These are only exposed if all memdevs
> participating in the region support both inject and clear commands,
> ensuring consistent and reliable behavior across multi-device regions.
> 
> If tracing is enabled, these operations are logged as cxl_poison
> events in /sys/kernel/tracing/trace.
> 
> The ABI documentation warns users of the significant risks that
> come with using these capabilities.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
