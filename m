Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A01FFC78
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067751; cv=none; b=gYLGlouvhUjtyb1bkwXjSPsCZCHqRoFC9w1cM6quxIfKQU5qOr7g1WZJ/1idh+AkkDhn1N/4yO+NfRavlyG581jVBLMG1hMEKuM74o0cIprKDxHyyEqdAXK6N8nf3LabUdN5JbLtUqZFl5SFEHG7Mg/tLhYkieAf9qpC8CtvQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067751; c=relaxed/simple;
	bh=8+oWzvPSnR87KEEUvqLlMYrz8o5sQyMopBLYZqBV8T8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiDbfUYCTiCVkIBvvnpoXIh8h6UIV3HEkTlTtBzxSsBhoP3ehGLeZqUvAoFLEEhHeix32RUgCy+Mr0Qe9PYL4jOh7r0XbWBitlRPnMxdn8r3dOY/0JuB/JQWXluPcgB4EvtXc9fegGHvZHzubOM8qJzjAjbtWiix4vuZ+++87HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzJ533zGPz6GBln;
	Fri, 21 Feb 2025 00:05:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9753C1400D9;
	Fri, 21 Feb 2025 00:08:53 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 17:08:53 +0100
Date: Thu, 20 Feb 2025 16:08:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2 0/3] CXL CCI Log Commands implementation
Message-ID: <20250220160850.00003016@huawei.com>
In-Reply-To: <20250218085731.550029-1-arpit1.kumar@samsung.com>
References: <CGME20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710@epcas5p3.samsung.com>
	<20250218085731.550029-1-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 14:27:28 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> CXL CCI log commands implmented as per CXL Specification 3.2 8.2.10.5
> 1) get_log_capabilities (Opcode 0402h)
> 2) clear_log (Opcode 0403h)
> 3) populate_log (Opcode 0404h)
> 
> This v2 patch addresses the feedback from the v1 patch and include some new changes.

I'll apply these to my staging tree, but it is a little odd
to have the last two commands without any logs that they actually apply to.

Maybe we should make up a component state dump?
I think that currently the populate only really applies to that
one (or the vendor defined one).

We can also look at wiring up the ECS logs and some suitable error
injection as clear log would apply to those.  I like the idea
of having media test longer term as well as the use cases for that in
kernel are interesting to explore.

Jonathan
> 
> Changes in from v1 to v2:
> - Added descriptive text for each patches
> - Added reference from CXL spec 3.2
> - Updated naming for better comprehension
> - Modified find_log_index() to return supported log
> - Handled array of log capabilities as static const pointers
> - Replaced bit fields for param_flags with defines for individual bits
> - Disabled support of clear & populate log command for command effect log
> 
> The patches are generated against the Johnathan's tree
> https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.
> 
> Arpit Kumar (3):
>   hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
>     (Opcode 0402h)
>   hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
>   hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
>     0404h)
> 
>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h  |  20 +++++++
>  include/hw/cxl/cxl_mailbox.h |   5 ++
>  3 files changed, 125 insertions(+)
> 

