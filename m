Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98081199945
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015711; cv=none; b=YAZ+cx++AAR2V6SXOAHyrpHodw8neiswoyOYKVwNkfskCRWspInQmnBUuXTxsCsasJjSbtNkdRGoDTtDkbkI3bn6KRjlWCjGUz7kSFa65WUgj+4NEdyiUjUSGWqa3EKHkom7151MHf2WV9CSogJwz7PS87j3nXshwY+CN1+zKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015711; c=relaxed/simple;
	bh=55ut21GPZXJGCJV8O+/nmZSzWe+tSqbKGH8KZEErevU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sz7faNnlzaaOSD6mZO+B/uBqvkNHTdnJ51mmOwXqtI+VR8BN0/Inuegi1mIvz8CDLihoYQV7nPuoZ3QSqrhwtiJ5Oqx3tbXSQk5snYqw0RZDrgduZG18Q3epGmaAdwqPZbBsMXcMBrj/a0hYNfNq4/MtYwGi8RT0MvHdUOSDO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFVC3KFHz67FXD;
	Fri, 30 Aug 2024 18:57:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0780E1404FC;
	Fri, 30 Aug 2024 19:01:47 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:01:46 +0100
Date: Fri, 30 Aug 2024 12:01:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cxl/port: Use __free() to drop put_device() for
 cxl_port
Message-ID: <20240830120145.00002ad7@Huawei.com>
In-Reply-To: <20240830013138.2256244-1-ming4.li@intel.com>
References: <20240830013138.2256244-1-ming4.li@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 01:31:36 +0000
Li Ming <ming4.li@intel.com> wrote:

> Using scope-based resource management __free() marco with a new helper
> called put_cxl_port() to drop open coded the put_device() used to
> dereference the 'struct device' in cxl_port.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
