Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC1153835
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655980; cv=none; b=RNikOz4RDH1ldvf4kELl4oelA6CYxLwOoQxINbjq9GPMDDNVkN4iZzXxedl8RO41tKqOUyONmJk2jUX7r1IXujKguwfwF9VHNzMVzCrwtyTyTgqFU94AQlt5oWJSQJY9ridBVr/jZOva1/iF6BSjTqYC0iZg95EPpH83A4zxH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655980; c=relaxed/simple;
	bh=iy4Hxf1jg1MQf9jhiLOp26FCNdRMBfnQLbVOA8404bA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/YE5G90Ott3p0AMcE+GG6zU0ZsAaZqwCDU+6L+BpNsFR7anH7fG2bsokuRyKSKu3wi9Mhvu9CWhvM7zmYidOPA0ufXFDilFw+wxQ3aatUly+ghOngm77cotZl55Iu2Dl2ZwHJA7jc6AujCtVsFm29kvd0SbjW02FbqIkY5uKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8Bq1CX6z6L563;
	Fri, 24 Jan 2025 02:10:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4076140CB9;
	Fri, 24 Jan 2025 02:12:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:12:55 +0100
Date: Thu, 23 Jan 2025 18:12:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 13/19] cxl: Move cxl feature command structs to user
 header
Message-ID: <20250123181254.00002b42@huawei.com>
In-Reply-To: <20250122235159.2716036-14-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-14-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In perparation for cxl fwctl enabling, move data structures related to
> cxl feature commands to a user header file.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
