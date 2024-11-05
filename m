Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C513D51E
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829738; cv=none; b=Ql19fCIAJrsoXQ4ea/QHIO/qQ6ATDjGZ42CrkU5fQ4odKCNtteH4M6P72+jW2WWR23H7GWgG9y8hO1XR2kxth6sHth2WlQYhXwlhh3xLDLC3JSxDWH8dAnj2C97E0N90Ey38V1RsD/qynkmmxQRbIaS/t8yD9HYwFBlwNs9sdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829738; c=relaxed/simple;
	bh=8Dzkh/jsk3l5wOFh6c0TxAwOwV31Dv3TTN/Q5CMSfIo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJp9wqK468pCQqozQp9mNWl8ezB24cJ1iT9M3G/E/k3XpqlEDFtAttcIp00qdrhp5tU4FJp98DC/eiqvupoTx/iiukaBz+lIfC8n3+DapNB0l34PmqG52rO7zamLMC3wxn2tX/OLX2dX7XEt5MZsBEGRezpXOlysAYuWzQvdJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkurGlQL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkurGlQL"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e60825aa26so3044704b6e.1
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730829736; x=1731434536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtHAX6e1gVp4XzhgXtLPhaxyRzN6pXwJugKNF4diKms=;
        b=GkurGlQLxMaClkijZV1KG4tpd3c1WJTdAf5YNeFyfZZfNpBMfri0MAtumv9ypSlCYW
         eq64Oi6dy/f3Kio3OUnlGVzc7aenAxXjSPCjiMaD6XpCTc+zptr5T9/wCt8ElqSFZp70
         tupOm3X42p9tfDpOfeo3bYhcjFrquJiXyvg83kd3Ig4PXKQFgX7ABr2bq3AlK9IgKT2u
         X1wTYFvuFA6dLiEIc8hBM6Zg758UllQTGKDOYOBqWnzZ4Lz2BeuzDYMOmmxxkl4CebYf
         I+ermfDR5mAeZClyD7VHEReCfKc5kH4BMCZZRPFMyX47JLvG30QUCbtQOPFdJyNuLx+p
         gXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829736; x=1731434536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtHAX6e1gVp4XzhgXtLPhaxyRzN6pXwJugKNF4diKms=;
        b=ssuOO9yRzWcPEfvtOerZZgSg45JKFVqFQTfLMEdJyR86TUB3ofCc7pFmeRusAgGIkL
         uZAHL0vJaRm9v2OfRC5hmjpwUpyb+Yw2ovB0B3Nk/PTkXG79VF3ZRwTDXlByn9L5YsZB
         RlysjhyimdHkn6sUXiZbptBxJI+df4ax/UKMgCl1rD/PyhHODqwHM9aEGc2A3jXKKoFh
         aGs08xvFqJHmJuNp+0h79aDEJHqDsteLpx+jrBZkwvypds0RcvPxPfx+I1l+Mw8+q0GH
         +3muxpR+Vde9SOcocD5qXb3n3TOaGii6XtbJRl1t/o+mzKpXhJM0iRUV3RXb8gNtUUeN
         oddQ==
X-Gm-Message-State: AOJu0Yz8aR13+MOm2xcovlteNAaG2C5XjsJQplpOdOFWl/NsNSelVogU
	uDlVoqcXuAArWCltGCnV0QVVJrz3BjeMcL42g8wDvCemFbAyRFKOv/hHZQ==
X-Google-Smtp-Source: AGHT+IExTdeGw8aLpG72eeW9Aj6hyRgVSH5StOOqnMPdPcgbLC7hQF38iw0EtfAfIhxkTbAQk2Yokg==
X-Received: by 2002:a05:6808:152c:b0:3e0:42ba:c59b with SMTP id 5614622812f47-3e758cb6ec1mr15776664b6e.40.1730829735661;
        Tue, 05 Nov 2024 10:02:15 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8aa2076sm2663139276.39.2024.11.05.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:02:15 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 10:01:53 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 01/10] hw/cxl: Check size of input data to dynamic
 capacity mailbox commands
Message-ID: <ZypdkVE5uD-0nCb2@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-2-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:08PM +0000, Jonathan Cameron wrote:
> cxl_cmd_dcd_release_dyn_cap() and cmd_dcd_add_dyn_cap_rsp() are missing
> input message size checks.  These must be done in the individual
> commands when the command has a variable length input payload.
> 
> A buggy or malicious guest might send undersized messages via the mailbox.
> As that size is used to take a copy of the mailbox content, each command
> must check there is sufficient data. In this case the first check is that
> there is enough data to read how many extents there are, and the second
> that there is enough for those elements to be accessed.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 97cb8bbcec..17924410dd 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2465,11 +2465,20 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      uint64_t dpa, len;
>      CXLRetCode ret;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (in->num_entries_updated == 0) {
>          cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>          return CXL_MBOX_SUCCESS;
>      }
>  
> +    if (len_in <
> +        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      /* Adding extents causes exceeding device's extent tracking ability. */
>      if (in->num_entries_updated + ct3d->dc.total_extent_count >
>          CXL_NUM_EXTENTS_SUPPORTED) {
> @@ -2624,10 +2633,19 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      uint32_t updated_list_size;
>      CXLRetCode ret;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (in->num_entries_updated == 0) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (len_in <
> +        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      ret = cxl_detect_malformed_extent_list(ct3d, in);
>      if (ret != CXL_MBOX_SUCCESS) {
>          return ret;
> -- 
> 2.43.0
> 

-- 
Fan Ni
