Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784C132103
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213370; cv=none; b=NVhwr/QSmCe2/+cYBlHOxJXWGZww3AvJ3BHYIi7FZvJhyjHHXARhBvsfvj1VwvTZvdGb7l7RnYeoFziI7f+A+kP+H5U/R+OoXN4Dm94D6NxGWc/3QsfDVFmE85DnGXMx+pi8BorrXoG6En84nmNXP434ECN4WKJ5wfyE59e2pBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213370; c=relaxed/simple;
	bh=qj1Mxjal1kG4nEAXlVp7ULNVkIm1qtibwyLsEUCjUWQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf6gHd6GDDFPdwLHjzRgSAGwAm72PF3/KBuh5cNsvgkuea40bqKOpj1HO1pC/rJ7py2THbVUK6YLSUPV24Q386He4DwEzhdwYcc4IrokCQguOvBqbrIB5FOmocWIJkH4cDrIuRyPHUkdFKhfU2frYYJ42NHdsXy9bY5i+4bhekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRNm20Wxz6K8Q7;
	Fri, 22 Nov 2024 02:20:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C8A581400F4;
	Fri, 22 Nov 2024 02:22:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:22:44 +0100
Date: Thu, 21 Nov 2024 18:22:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 12/20] cxl: Save Command Effects Log (CEL)
 effects for enabled commands
Message-ID: <20241121182243.000037fe@huawei.com>
In-Reply-To: <20241115212745.869552-13-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-13-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Store the command effects via what device provided via the CEL in the
> 'struct cxl_command_info' structure. Steal the upper 16 bits to store
> the effects value in order to keep user API compatibility.

Trivial comment inline.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c      | 2 ++
>  include/uapi/fwctl/fwctl.h   | 4 ++--
>  include/uapi/linux/cxl_mem.h | 5 +++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f464eb42f08a..fba6bdd30a82 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -795,6 +795,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		cmd->info.effects = le16_to_cpu(cel_entry[i].effect);
> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 7334907e27c1..04da549cd4ae 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -74,8 +74,8 @@ struct fwctl_info {
>   * struct fwctl_command_info - Hardware command information returned from a query.
>   * @id: Driver ID number for the command
>   * @opcode: Hardware command opcode
> - * @set_effects: Effects to the OS and hardware when command is executed.
> - *               Provided by the device.
> + * @effects: Effects to the OS and hardware when command is executed.
> + *           Provided by the device.

Wrong patch...

>   * @size_in: Expected input size, or ~0U if variable length.
>   * @size_out: Expected output size, or ~0U if variable length.
>   *
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 469dd481795f..9dd37849c450 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -118,6 +118,7 @@ static const __u8 cxl_deprecated_commands[]
>   *         the label-storage-area can not be written while the kernel is
>   *         actively managing that space.
>   *
> + * @effects: Command effects reported by the device.
>   * @size_in: Expected input size, or ~0 if variable length.
>   * @size_out: Expected output size, or ~0 if variable length.
>   *
> @@ -136,11 +137,11 @@ static const __u8 cxl_deprecated_commands[]
>  struct cxl_command_info {
>  	__u32 id;
>  
> -	__u32 flags;
> +	__u16 flags;
>  #define CXL_MEM_COMMAND_FLAG_MASK		GENMASK(1, 0)
>  #define CXL_MEM_COMMAND_FLAG_ENABLED		BIT(0)
>  #define CXL_MEM_COMMAND_FLAG_EXCLUSIVE		BIT(1)
> -
> +	__u16 effects;
>  	__u32 size_in;
>  	__u32 size_out;
>  };

