Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E620551F;
	Fri, 10 Jan 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525211; cv=none; b=tb19nPWJ55fFf2TYKLBeRwI+r0RcTPTH2bPG+yRN7IkhVprpILQqeOz4L9Znf0Fwqo8yiE2FzsbPfbUlLKMadKDdLFIGwiukrieE5CeMTKYx1LQtoN+ft20Sn1gQgHFk3QzmxLBem2UA20QIIye9N96KqZDDTtiPF0TtAhJjYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525211; c=relaxed/simple;
	bh=X5uJ2d4Frw2p6RQLVQlpcIJMO5IqfY/W26Jd0yHvWN0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpeaU7gpcmLBnS2cjcdtmO8shXczaqqb59Ne5oYdIltmggThMrpKDrpghzXlVKrlk7AVgx4rvyeFiI8LA9gQJddKklhoAJQLFl95xtR8e7IBVOqutgZ4G2JBt80sJjMiSGr5gAJngULubx6yMj0W6EyjmbS8C78wdyw95MjR0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV5y56j3Vz6JB35;
	Sat, 11 Jan 2025 00:02:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A28C140CF4;
	Sat, 11 Jan 2025 00:06:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 17:06:46 +0100
Date: Fri, 10 Jan 2025 16:06:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Message-ID: <20250110160645.00007b74@huawei.com>
In-Reply-To: <20250110115556.1654-1-shiju.jose@huawei.com>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
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

On Fri, 10 Jan 2025 11:55:50 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add updates in the CXL events records and CXL trace events implementations
> for the changes in CXL spec rev 3.1.
> 
> Shiju Jose (6):
>   cxl/events: Update Common Event Record to CXL spec rev 3.1
>   cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
>   cxl/events: Update General Media Event Record to CXL spec rev 3.1
>   cxl/events: Update DRAM Event Record to CXL spec rev 3.1
>   cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
>   cxl/test: Update test code for event records to CXL spec rev 3.1
> 
> Changes:
> V4 -> V5
> 1. Reverted changes made in v4 for overcoming parsing error when
> libtraceevent in userspace parses the CXL trace events, for rasdaemon.
> This was due to trace event's format file is larger than PAGE_SIZE, not
> supported reading complete format file in one go in the kernel and thus
> fixed in the rasdaemon.

Great to see that resolved.

> 2. Rebased to v6.13-rc5.

Should probably say why when doing a rebase to something other than rc1.
In this case this is what cxl.git/next is based on after some fixes earlier
in the cycle so a sensible choice for this set.

As far as I'm concerned this set is ready to go, but more eyes always good
if anyone has time! Same for the ras-daemon series once this is queued for
the kernel.

Jonathan

> 3. Tested with rasdaemon and ras-mc-ctl tools updated for CXL spec rev 3.1
>    event record changes.
