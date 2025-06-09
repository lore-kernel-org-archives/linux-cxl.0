Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01121B196;
	Mon,  9 Jun 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488754; cv=none; b=kLddrXwTGvvVR5jsB8XXrEB5K27K7J2RVuHHdbn7ozHVRg2owV+t3mYjCVNhDh9R38MHRACJgZFrKCfZiPwUJrB1bmDEHKjxGodOwlLT8xXLzEZVBYMCqQNp52XcJ0Aiz8XI9cO6xWBn59+6Frxs5ywWw7H45sUt0xmR/UE5PKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488754; c=relaxed/simple;
	bh=LMqM1bzqqA6GzoF9KcOSowI3oyydWM2x+aSFWvoAQ60=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC0YK/nhtsWX4JREmyIJKKk9Y3P8ze0ldv9erJ4kJNXGHF0xMtrN1LaTHOVF34Pc6EP+7ytDCrq4Ob7nPtxaECF0VEf+V/kHvZjgAJ4psjl1HDZzbKFbFQ9dip1QsLdDWgatFz1ES6krLX4yGl2sMxmRD9f27bodYj0rbjUzIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGJDJ4vJbz6L4sh;
	Tue, 10 Jun 2025 01:04:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A971140276;
	Tue, 10 Jun 2025 01:05:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 19:05:47 +0200
Date: Mon, 9 Jun 2025 18:05:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] cxl/Documentation: Add more description about
 min/max scrub cycle
Message-ID: <20250609180545.00003839@huawei.com>
In-Reply-To: <20250603104314.25569-2-ming.li@zohomail.com>
References: <20250603104314.25569-1-ming.li@zohomail.com>
	<20250603104314.25569-2-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  3 Jun 2025 18:43:14 +0800
Li Ming <ming.li@zohomail.com> wrote:

> user can configurare scrub cycle for a region or a memory device via
> sysfs interface. Currently, these interfaces have not enough description
> for the return value. So adding return value description to these
> interfaces.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
