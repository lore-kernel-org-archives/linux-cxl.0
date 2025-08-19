Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2900261B80;
	Tue, 19 Aug 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602962; cv=none; b=nrYeqPg8EqPW0SSI5bserS+bCWGHTTl8MEjlsodZ5fbRb2kS3EBokYDKFZASqSPkb18s7rhR8BdCDmxgsU+ZJF2h+uuEjVnJYFpYf3Kd62Uk86OkiGevoNjkNIKihX60QSYZZwZk/xDExvDKHD6X6VFtWlXFVGzyB2G0diwWUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602962; c=relaxed/simple;
	bh=IlnWSJV3KzsuMORhmieQKr1kfmdHvuAugMFbiqpc4hM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFj07tvgKjITBRCIql3ZzFhuVbkI08USzGI+ImiGhCA2vl7KVaJLpD/obdlDLWy1E7tP0nCG4oWYG2y3gkVtCdR0PP3emrZPw5x3HQtcjWy7cUbvrVYCxRdPy0AB8VS8Ay1EreTcZiWCOFmISq25oXiBNLC7IoCr6y9w2kTW3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5nMr3D6fz6H7rC;
	Tue, 19 Aug 2025 19:26:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50255140427;
	Tue, 19 Aug 2025 19:29:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:29:15 +0200
Date: Tue, 19 Aug 2025 12:29:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Rakuram Eswaran <rakuram.e96@gmail.com>, <linux-doc@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<alison.schofield@intel.com>, <gourry@gourry.net>,
	<skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linuxfoundation.org>, <corbet@lwn.net>
Subject: Re: [PATCH v3] Documentation/driver-api: Fix typo error in cxl
Message-ID: <20250819122914.0000062b@huawei.com>
In-Reply-To: <1232c1c6-5bea-4378-b3ee-041b75a87b94@intel.com>
References: <20250818175335.5312-1-rakuram.e96@gmail.com>
	<1232c1c6-5bea-4378-b3ee-041b75a87b94@intel.com>
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

On Mon, 18 Aug 2025 15:47:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/18/25 10:53 AM, Rakuram Eswaran wrote:
> > Fixed the following typo errors
> > 
> > intersparsed ==> interspersed
> > in Documentation/driver-api/cxl/platform/bios-and-efi.rst
> > 
> > ---
> > Changelog:
> > 
> > Changes since v2:
> > - Fixed Signed-off-by line to include fullname
> >   (feedback from Jonathan Corbet)
> > 
> > Changes since v1:
> > - Dropped fix for page-allocator.rst as requested by Gregory
> > 
> > Suggested-by: Gregory Price <gourry@gourry.net> 
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
FWIW

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

