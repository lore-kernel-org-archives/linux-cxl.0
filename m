Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7932255E;
	Tue, 19 Aug 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602900; cv=none; b=AvF2zNR8iL7MNaPZQZfiM3K64nMUYDWKdcNQnDlAeob0+LjCataTC0PniC4cCFPB4uU8J604XTNs1HXUHfTodZrbK3/iADasalqADxIJA13QHWbkbVLjyHO63EoIZ59VMzP5pRNvI6qJBngzhUI3Mcr08P4k6UehXh8FnAOe0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602900; c=relaxed/simple;
	bh=tQPDpEhl7zy9pGngPafFjhLpKYU6065+GnNw3KMFusI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4/1K0O/iScLr2PqzszwjiPa/Q2G6jn2RpuO93qAihSiHEPedjO0Hdb5bJ2JYd8xvraGmM+P3ehMkkZc4wN1CiJipcDqOxPER6usTV+6gfvxTI/qxBvhNpUkkFWRB6pFmi8ztV0cPGdYGwkeKFUE5RMgh7r+Hrwyxwo9GKIYQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5nMg1cSVz6GFtT;
	Tue, 19 Aug 2025 19:26:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A8D21400DC;
	Tue, 19 Aug 2025 19:28:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:28:12 +0200
Date: Tue, 19 Aug 2025 12:28:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Moktar SELLAMI <smokthar925@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>, Gregory Price
	<gourry@gourry.net>, Alok Tiwari <alok.a.tiwari@oracle.com>,
	<linux-kernel-mentees@lists.linuxfoundation.org>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
Message-ID: <20250819122810.00006ca3@huawei.com>
In-Reply-To: <20250819084116.13108-1-smokthar925@gmail.com>
References: <20250819084116.13108-1-smokthar925@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Aug 2025 09:41:16 +0100
Moktar SELLAMI <smokthar925@gmail.com> wrote:

> Fixed Typo in the driver-api/cxl/devices/devices.rst
> 
> functionalty -> functionality
> 
> Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  Documentation/driver-api/cxl/devices/device-types.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> index 923f5d89bc04..7f69dfa4509b 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>  Typically used for initialization, configuration, and I/O access for anything
>  other than memory (CXL.mem) or cache (CXL.cache) operations.
>  
> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>  interfaces and /dev/cxl/ devices (which exposes direct access to device
>  mailboxes).
>  

