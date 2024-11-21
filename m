Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69915ADB4
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213244; cv=none; b=BQ2ZwpPSdeAPfixy5HeTR6hArN3Lf2sabmlq10dcQ0plKqvAYofCySYW+AK/b5F7Fd2AjVLH/tYUSIDG/F6QlgJ8Dh39ufQNA1Qpf0RXWgccUqB3nxk/8Heitm4RprVCkPJ3NctCWfurKI3k7s379oThr91tZPXTOGZm5OPtaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213244; c=relaxed/simple;
	bh=iBqvlsmyQvh5WYCqMzG0nTR/YX+/QycrAwfJYlf+lQY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCtmQY6vzBuaSyVdILqygaYedgATW27rDzf8xUjQjS1vfitz7Hc7uynC4BNxCymzpeXGKpnwPxVE2Qd6DH9qzwls8qi5BT8KMlTRYKNQ7roHm0r5M1U72EgNlvfuhpqA2ta2pvEyM5Vh0UwTNxU1Xkwza779gXqBCAj1HkJs3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRNY6dX5z6L6pJ;
	Fri, 22 Nov 2024 02:20:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 44673140157;
	Fri, 22 Nov 2024 02:20:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:20:37 +0100
Date: Thu, 21 Nov 2024 18:20:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
Message-ID: <20241121182036.00006f6e@huawei.com>
In-Reply-To: <20241115212745.869552-12-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-12-dave.jiang@intel.com>
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

On Fri, 15 Nov 2024 14:25:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add an optional ioctl FWCTL_HW_INFO to pass command specific information
> to user space. An array of 'struct fwctl_command_info' will be returned
> from the ioctl. These commands are send to the driver via FWCTL_RPC call.
> The command info struct contains the command id, the related hardware
> opcode, input and output size for the command, and the effects the command
> has if it's a write command.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Minor stuff inline.

Jonathan


> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 4e4d30104667..7334907e27c1 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h

>  enum fwctl_device_type {
> @@ -69,6 +70,61 @@ struct fwctl_info {
>  };
>  #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
>  
> +/**
> + * struct fwctl_command_info - Hardware command information returned from a query.
> + * @id: Driver ID number for the command
> + * @opcode: Hardware command opcode
> + * @set_effects: Effects to the OS and hardware when command is executed.
> + *               Provided by the device.

Run kernel doc over the files.  (wrong name)

> + * @size_in: Expected input size, or ~0U if variable length.
> + * @size_out: Expected output size, or ~0U if variable length.
> + *
> + * Represents a single command that is supported by both the driver and the
> + * hardware. This is returned as part of an array from the FWCTL_HW_INFO ioctl.
> + */
> +struct fwctl_command_info {
> +	__u32 id;
> +	__u16 opcode;
> +	__u16 effects;
> +	__u32 size_in;
> +	__u32 size_out;
> +};
> +
> +/**
> + * struct fwctl_hw_info_out - output struct for FWCTL_HW_INFO
> + * @nr_cmds: Number of commands for output
> + * @reserved: Reserved u32 for alignment.

As currently defined, why do we need to pad? I'm not against
padding just not understanding the comment.
It's more fun if there is a u64 in there (we all love 32 bit
x86 data alignment).

> + * @commands: Array of 'struct fwctl_command_info'
> + */
> +struct fwctl_hw_info_out {
> +	__u32 nr_cmds;
> +	__u32 reserved;
> +
> +	struct fwctl_command_info commands[] __counted_by(nr_cmds);
> +};

