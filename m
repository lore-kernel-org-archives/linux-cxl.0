Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BD28D821
	for <linux-cxl@vger.kernel.org>; Fri,  4 Jul 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623042; cv=none; b=sDBm3EvyCxJ55q/8nl/a3XCnABVKMwopTgCa6UkU1+vSFw2/MjYg+sUBDQQ+dxU6Uep5UyyKIpE9mV4WCyQW9NEVh3h6QGTLT/Uzo2ngQ8BcEaN5kEHa6euffdhw7JSjyjTQNZK30XudXLecxViltRvNU6H36uxxYi8j4HmXFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623042; c=relaxed/simple;
	bh=MW6cOVkhB28qOvt9jA7gfBIq20JixtOFxwJyp+9SwhU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3wIpIsem/sPzu8n+EfBCzjZS+eMOK9suuwkvJmXlcInrSMqhoBfbzs8lXuo+gk1SlC1ius3hzZIb9UUTcs20QnhyANPFcsI3PHidlNC91d1RSCmCt0GSzOh7OMedResrq5LddkbEqQ9iPqbVy5d0mYXtAaVTH2x9iO5JE+o+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYTYB3h0bz6M5M2;
	Fri,  4 Jul 2025 17:56:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E67671402F1;
	Fri,  4 Jul 2025 17:57:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:57:12 +0200
Date: Fri, 4 Jul 2025 10:57:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 06/10] cxl/test: Add mock version of
 devm_cxl_add_dport_by_dev()
Message-ID: <20250704105711.0000529b@huawei.com>
In-Reply-To: <20250703232710.3141436-7-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
	<20250703232710.3141436-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 16:27:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
> hierarchy. However with cxl_test, it needs to be done through the
> platform device hierarchy. Add the mock function for
> devm_cxl_add_dport_by_dev().
> 
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late dport allocation changes in order to enable cxl-test.
> 
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I'm never totally confident on cxl_test stuff but fwiw looks find to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

