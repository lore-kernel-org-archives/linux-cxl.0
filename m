Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF21AC8AE
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917556; cv=none; b=H8sY8NIuzw+V8j7ehavWVWm27yIZXMhBk+5osgi1cyzF2BK2arOIbxxeNPNiX6kihvqVF+ucyU5TStmIPNvEPl6chRGsAHZ2f/V1PQf7XNddbUkzN6zMu45NedZ6wPF0M7+dIAbeQySo+hTl+yEYd0kSVM/wLjOYDBv58Ox4M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917556; c=relaxed/simple;
	bh=WA75nAoCHRADyPsjPVGirVYEGJOKKIKcHfQBy7n0M5c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXQj6FfafthXdRZ/rXWTjvA5P7kZXdVKvzPfyMOyytOnmLrt5to1opAf2Nb4PFgYY3Zqc5zdgUZLOVDfTYUSAAOV1TYn1mZ0x5VQyEYO00qyrXVWuYweBoKUJF9yJkq4pxK5BGHK+DZKGLSKY7kLcRilk/8FAutTJyl8kLEb1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS0Xf2DrPz6GBnl;
	Mon, 14 Oct 2024 22:50:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 17615140A77;
	Mon, 14 Oct 2024 22:52:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:52:32 +0200
Date: Mon, 14 Oct 2024 15:52:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>
Subject: Re: [PATCH v4 1/3] cxl: move cxl headers to new include/cxl/
 directory
Message-ID: <20241014155231.00003a81@Huawei.com>
In-Reply-To: <20240905223711.1990186-2-dave.jiang@intel.com>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
	<20240905223711.1990186-2-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 5 Sep 2024 15:35:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Group all cxl related kernel headers into include/cxl/ directory.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
