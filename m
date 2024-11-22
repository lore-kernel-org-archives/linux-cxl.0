Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD034207F
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289222; cv=none; b=uJqB3CEnJhFr4CDoM0TooP4MiMZLKviMe0TgOanv4F2lleeCcOd3M3aOG2kVeui6DAH/5T866yK+Ff5YgABNFqsDrv4sOKWIduYrHNtiS2wNG42EyGnbJARg/I3s/80+4+h73GlDOLPsLQelrFU/c8wb4TIUuy7g3dDjuYf1/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289222; c=relaxed/simple;
	bh=LWFHKTlFBDI4Q+Xn/db/g3DpQpIVJeHZMJiaoYI9CwM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD8/NLyMKOa2VDBWOhExxtxIuqcBq+2QVf3iwa7mwBBV1rwoZ4XbawM76C2Bd7dif1gJC+Sg3dX/1N0JKq48A8FE81QeRacN6XBgxxh+VwK1BmSXTOJBjaH4i8D+LkC6De3MG9dRSzpxjgBdl5KLt/POTUV45JDb9zACxynA2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvzRQ0z6Vz6K8vt;
	Fri, 22 Nov 2024 23:24:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A2E2140134;
	Fri, 22 Nov 2024 23:26:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:26:56 +0100
Date: Fri, 22 Nov 2024 15:26:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 20/20] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <20241122152655.0000717d@huawei.com>
In-Reply-To: <20241115212745.869552-21-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-21-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:53 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add policy and operational documentation for FWCTL CXL.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  .../userspace-api/fwctl/fwctl-cxl.rst         | 91 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> new file mode 100644
> index 000000000000..158e9aa45609
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> @@ -0,0 +1,91 @@
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
> +While there are a large set of mailbox commands, only the feature related
> +commands will be allowed to be issued through fwctl initially. No background
> +commands will be supported at this time.
> +
> +CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> +CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
> +CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> +
> +The "Get Supported Features" return data may be filtered by the kernel driver to
> +drop any features that are forbidden by the kernel or being exclusively used by
> +the kernel. The "Get Supported Featuers" command falls under the fwctl policy
spell check. Features

> +of FWCTL_RPC_CONFIGURATION.
As per earlier feedback I think we need to reject get/set even if they are not
listed in get supported features so that bad userspace doesn't get away
with sending them anyway.  This is particularly necessary as I suspect we'll
be removing features in the long run from what we let be accessed this way.

I'm not sure how we document the potential for removal of a feature that
was reported by an earlier kernel.

Jonathan




