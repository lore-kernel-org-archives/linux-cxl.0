Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76113DB64A
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931584; cv=none; b=kbtA18XTamY8R9TVJ5fnknEyHESDODXVyVvOARu3Qc0K+ZQHahgVX5tQAiXb6MvFHPBUMWPyP8NBYqaNoWwWSIoZXk4mN5OfkzCW0vXi7rH+0wH1WoOoVA0dy8rbznyjceHlUreK/6hv0Kb+kEaJ9RwFXXi0sehs6ExsOLz9Kus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931584; c=relaxed/simple;
	bh=GpwzLECu5syA0AlYPyZ1nCDW9NS/Dv9wMuxilDlCY68=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2WvNTRTEAr4A0UkzYgbD/IMamWZbp2NIEaPbBUgMHVqnt1oxztjMRda10cZtIXAsx7ZSfOdQPo4Ol7OAne6tmQHTMyhh9lmUONdErxXfjvA4tfrjq3lAquerTpWjEA7NVNUOjtcJkWw+q5kiFpWBL5II4+5G6ho/xKyZj4Ke6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc7mJ0Vj7zHnGjS;
	Thu, 19 Mar 2026 22:45:52 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B68274056E;
	Thu, 19 Mar 2026 22:46:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 14:46:15 +0000
Date: Thu, 19 Mar 2026 14:46:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset
 happens
Message-ID: <20260319144613.00003ea6@huawei.com>
In-Reply-To: <20260317234926.3545119-1-dave.jiang@intel.com>
References: <20260317234926.3545119-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Mar 2026 16:49:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Rename CLEAR_MASK to RESET_MASK (Alison)
> - Make the helper function take a mask argument to specify which flags
>   to clear (Alison)
Unless we know of another use for this helper, I'd have gone with
Alison's other alternative of just giving it a more specific name
and not passing in a flags parameter.  Feels like a bit of premature
generalization!

