Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886043F08D;
	Wed, 12 Aug 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537404; cv=none; b=gjFCoTJPLnFe6d1NMqxcOLGoNczNEZO2xujYd9ZZfuWD4WzJpDGsLE0wqdIPHbZ2doeX+2IZ0y46rip2YMEfAE9eH8dBKgn3cD4Cyex+Nw2eDdYDYcroxbJ40xYgj31THRSVIzARp/hF3gNJmnWoaB9dFvFFC7Dxvr+6qCwIOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537404; c=relaxed/simple;
	bh=MNCRtzfXC+IqdcVMOja2IXZMm0xUiHMHFTfjHRLsd5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea7s+avI3/GhI6Rur6JHwNRNWo3ZekqEUzD/hdMryTcqtjFy/xl+uBHjwuO/RPr4W9/k4YXnmyzdv8TF1n2W8lXwWO/3qxSjD+oqHMIwv82d0WNA+2XY8hgdAJ20NvGqpZ9jmeaBLO/Fmvyk8tPQF9FKJJdLq6SGAVTiFdlDfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YlUvElmb; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YlUvElmb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786537397; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=385CdUyb4G1i0luA92j6hV6WKubCpFxmyjl5wKcFqbg=;
	b=YlUvElmb4sxYjZExbFKF5+k2jt57zZxj+vzwVMpGEvmny2TBJM7w6pEBk3WuXe2EnAK7SDozCkjOPB5soYvMgjZ2NtS5gY5Txm3vmB0bbYcEAQSz07tttmj20yH9gStpBSirafAwD4ZRjbhT+zxxZ0BErTCV2gg5ZlSQcsEethk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rd6Vd_1786537395;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rd6Vd_1786537395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 20:23:16 +0800
Message-ID: <57b7b281-b61c-4151-b2fc-1b589ffa17fe@linux.alibaba.com>
Date: Wed, 12 Aug 2026 20:23:15 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] efi/cper: Reject CPER records with an
 out-of-range error_data_length
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-3-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that the "len < sizeof(*rec)" guard added in this
> series can be bypassed by an integer overflow in the shared length check.
> 
> cper_estatus_check() bounds firmware CPER data before the section
> handlers in ghes_do_proc() run. It sizes each section with
> acpi_hest_get_record_size(), which adds the firmware-controlled u32
> error_data_length to the header size using signed int helpers in
> <acpi/ghes.h>. A value like 0xffffffb9 sign-converts to a negative
> number, wraps the record size small, and slips past the
> "record_size > data_len" check. A section handler then copies a
> fixed-size payload out of it and reads past the record.
> 
> Reject a section whose error_data_length is negative once sign-converted
> or larger than the remaining data, before the size arithmetic runs.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
> Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - New patch. Fix the signed error_data_length overflow that lets a
>    crafted section bypass cper_estatus_check() and defeat the per-caller
>    size guards (sashiko).
> ---
>   drivers/firmware/efi/cper.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..99a86b2675e3 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -765,6 +765,16 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>   		if (acpi_hest_get_size(gdata) > data_len)
>   			return -EINVAL;
>   
> +		/*
> +		 * error_data_length reaches record_size below as a signed int
> +		 * (see <acpi/ghes.h>), so a value with the sign bit set can
> +		 * wrap record_size small and slip past the bound check. Reject
> +		 * it before the arithmetic.
> +		 */
> +		if (acpi_hest_get_error_length(gdata) < 0 ||
> +		    acpi_hest_get_error_length(gdata) > data_len)
> +			return -EINVAL;
> +
>   		record_size = acpi_hest_get_record_size(gdata);
>   		if (record_size > data_len)
>   			return -EINVAL;

Minor: Could pull the helper result into a local, it's called twice.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

