Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDA1A5B85
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744371; cv=none; b=cXatIRXdSZuYbEQ/CVE+wau9rmaOhjBsOTKj25+DI+Ut4jWIPToLBHLdIpYR/8RoutwJ5rnPFn9VHkVB1qVQlK5ZBOTvv2hXzsuKA/IxsAx0J9aH8ptCsSSwQHseQ8b92iOjVooKS7J8Hqs4S8GGzps6BM5zlm+GvmHz32KBb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744371; c=relaxed/simple;
	bh=aIi2WTPS6zZeXfCMqNIFMbnnrL/ilxXRD2ZHViJMfwc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTGa+T1g5D+YmNwEdgSO3gtbwgNT9Do58IN98qlV+/psmMFJkSeBj8AN7BCCtGywInpeuZp7Q6EBOT+0zbtEEGqsu8iQt8+eI/yQn7rO3Z8nP/s6J0i0U6HV9Felk9nQyEO2aAfWNag0So+ibpBAqItZPHe+GQjTG6CsRSrETw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1v3043t8z6M4r5;
	Tue, 20 May 2025 20:27:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E86814050C;
	Tue, 20 May 2025 20:32:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 14:32:46 +0200
Date: Tue, 20 May 2025 13:32:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 07/10] cxl: Change sslbis handler to only handle
 single dport
Message-ID: <20250520133244.00004cc4@huawei.com>
In-Reply-To: <20250507004310.3536991-8-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:07 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems reasonable.  Any reason not to yank this one out before
the rest of the series as a bit of cleanup?

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
