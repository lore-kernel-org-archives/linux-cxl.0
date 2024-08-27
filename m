Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA81CD31
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760361; cv=none; b=DFKZrzSCCoaEFJuaMR37K1qIDjQ5N6n+N0QDJgyoSyxWEW4+CyXsE+pjHq3QYCY6Gs0hTc1KcRTdVADpgFkCaLbT3e+aKtL11gjdFVe8ybtq1L5CZEtguEFzf3iyon11LWPoXIbh6mVUd1iSWqD64tYBx3z1G8dtnIpMuM6CsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760361; c=relaxed/simple;
	bh=+qRTkkHW0zKM3ssb0J5d5hjt6/f5zAl/MS0HufLethg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=La+kBAD1JexrPWvyIMTYhSyysrxUr4DY0jj9841potKitd2hWmkxE+BGEIrJBFJkt3j3I1vEWeWVP7PsobcuO2hG8fmD4XVppGiHdY0BCjbWJRdPUNXpU+SjmoAODTxXb3+7ukBmtX+TW0Fg3zdFrWNNqeICSPvKQ45Di7A28rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtR4d0RHsz6DBfq;
	Tue, 27 Aug 2024 20:02:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0617140B39;
	Tue, 27 Aug 2024 20:05:55 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 13:05:55 +0100
Date: Tue, 27 Aug 2024 13:05:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop
 goto pattern
Message-ID: <20240827130554.000049b3@Huawei.com>
In-Reply-To: <20240826083058.1509232-3-ming4.li@intel.com>
References: <20240826083058.1509232-1-ming4.li@intel.com>
	<20240826083058.1509232-3-ming4.li@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Aug 2024 08:30:58 +0000
Li Ming <ming4.li@intel.com> wrote:

> The "goto error" pattern is not recommended, it can be removed via
> refactoring.

I'd avoid this first comment.  Goto error is fine, but not when
it is not used for all error paths after the first one where it's
relevant (which is what is happening here)

> In __devm_cxl_add_port(), there is a 'goto' to call
> put_device() for the error cases between device_initialize() and
> device_add() to dereference the 'struct device' of a new cxl_port.
> The refactoring is introducing a new function called cxl_port_add()
> which is used to add the 'struct device' of a new cxl_port to
> device hierarchy, moving the functions needing the help of above
> 'goto' into cxl_port_add(), and using a scope-based resource management
> __free() to drop the open coded put_device() and 'goto' for the error
> cases.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Nice.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwaei.com>
