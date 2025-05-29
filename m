Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC021D3D1
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531290; cv=none; b=g8800gsVBlGCtdwcjBbnziC8t5+5R0v8dmZUAa/4AYxIY/96oqzSqfzYuJthq45DihoQLnlXNbs8H81umGfPOSj+jK08cg9Zq5EIzeCXMn9yOb9eFXnBzhQCQkeOAPxuREH6wrHn0E5wIwlPRecOc+HGJxjDKWb5E73MJjnb4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531290; c=relaxed/simple;
	bh=aorCbkuZ9UmRAR9FHX67wLpGVJmDrwT20UBanML+gyM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVpAparDP6vo4zY0Jdvd2NevaaMoefH5E5mCUvPOm+Ol7UIB+P5VHkJwaA4jcKvCWOd6vWa+AbPUaytZre3zLuznf9PXtPHlyZCpoF4JRik79/YFOpSjqCWsG/zQ9rRRucuuABCCl+Ge6DdpZT89dCNxJjFgE7XPbOr3Y2swTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7V9W202wz6K8hM;
	Thu, 29 May 2025 23:07:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 81B8514022E;
	Thu, 29 May 2025 23:08:03 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 17:08:02 +0200
Date: Thu, 29 May 2025 16:08:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, "Itaru Kitayama"
	<itaru.kitayama@linux.dev>, Philippe =?ISO-8859-1?Q?Mathieu-Daud?=
 =?ISO-8859-1?Q?=E9?= <philmd@linaro.org>, Alireza Sanaee
	<alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <20250529160801.00003ade@huawei.com>
In-Reply-To: <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
	<20250528110726.226389-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 28 May 2025 12:07:23 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Previously these somewhat device like structures were tracked using a list
> in the CXLState in each machine.  This is proving restrictive in a few
> cases where we need to iterate through these without being aware of the
> machine type. Just make them sysbus devices.
> 
> Restrict them to not user created as they need to be visible to early
> stages of machine init given effects on the memory map.
> 
> This change both simplifies state tracking and enables features needed
> for performance optimization and hotness tracking by making it possible
> to retrieve the fixed memory window on actions elsewhere in the topology.
> 
> In some cases the ordering of the Fixed Memory Windows matters.
> For those utility functions provide a GSList sorted by the window index.
> This ensures that we get consistency across:
> - ordering in the command line
> - ordering of the host PA ranges
> - ordering of ACPI CEDT structures describing the CFMWS.
> 
> Other aspects don't have this constraint. For those direct iteration
> of the underlying hash structures is fine.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll not post v15 for a while to give time for review, but I just realized
this snippet was in a patch I was carrying on top of this and should have
been in this patch.

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index a610795c87..de66ab8c35 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -46,7 +46,6 @@ typedef struct CXLState {
     bool is_enabled;
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
-    GList *fixed_windows;
     CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;

