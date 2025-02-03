Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09940204F7F
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588141; cv=none; b=lzwQti93Ekm5bDX1XACvWIgiF04koau4Jcxfk+pU0iGtrx/jT5Ypv3GQb1yvpyOMRMXjiBD6xCX8PhdQHT/ql0hCNQBsTybF1FpyVQdPXhTjPaaLzJvtZSCT1X5DuAVsuf5K86xF8lr6r7Jg2S0gIUcPq/MuelB8cvp2AW9UYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588141; c=relaxed/simple;
	bh=VQzW2wYHFHrsqqN8t6hX47rB8hoSBFb2jbithwxn7NI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5WtUR4CIP1cmVUk6JOWXjXzAVaX7ewxwmc6dAh6Gqi+NAK4Q2he6KhZSyOYl1sVpqPlqcdZRnmlPtfjNTmCNFb4tqNOGCcFU7YuGNxlL+CpWPslZwkuR2IU9j/Qy9kfX9wTYY6RXIOLJPQMRSjpC0yfE77Se8H7GLAF+DZDeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymmwf5tJxz6M4T5;
	Mon,  3 Feb 2025 21:06:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 90C2F1400CA;
	Mon,  3 Feb 2025 21:08:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 14:08:55 +0100
Date: Mon, 3 Feb 2025 13:08:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 16/16] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <20250203130853.00004a07@huawei.com>
In-Reply-To: <20250201004459.466499-17-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-17-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)


One minor comment.  With a sentence added on that (assuming I didn't miss
it somewhere)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> new file mode 100644
> index 000000000000..8d9aeb77bc6d
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> @@ -0,0 +1,135 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl cxl driver
> +================
> +
> +:Author: Dave Jiang
> +
> +Overview
> +========
> +
> +The CXL spec defines a set of commands that can be issued to the mailbox of a
> +CXL device or switch. It also left room for vendor specific commands to be
> +issued to the mailbox as well. fwctl provides a path to issue a set of allowed
> +mailbox commands from user space to the device moderated by the kernel driver.
> +
> +The following 3 commands will be used to support CXL Features:
> +CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> +CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
> +CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> +
> +The "Get Supported Features" return data may be filtered by the kernel driver to
> +drop any features that are forbidden by the kernel or being exclusively used by
> +the kernel. The "Get Supported Features" command and the "Get Features" falls
> +under the fwctl policy of FWCTL_RPC_CONFIGURATION.

Document what 'filtered' means given change to zero sized set?

> +
> +For "Set Feature" command, the access policy currently is broken down into two
> +categories depending on the Set Feature effects reported by the device. If the
> +Set Feature will cause immediate change to the device, the fwctl access policy
> +must be FWCTL_RPC_DEBUG_WRITE_FULL. The effects for this level are
> +"immediate config change", "immediate data change", "immediate policy change",
> +or "immediate log change" for the set effects mask. If the effects are "config
> +change with cold reset" or "config change with conventional reset", then the
> +fwctl access policy must be FWCTL_RPC_DEBUG_WRITE or higher.

