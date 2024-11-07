Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBA200B99
	for <linux-cxl@vger.kernel.org>; Thu,  7 Nov 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993970; cv=none; b=clyp/ZSVlMkILEZmnbWTLUGudJTaUXvDiAZX0elXXcpJwOsgHUhslbehfFp8dsj7KEH9YAYp81PPZMPdjN+H+ugyBCiIfgZ2OVxHB3DmzAQ4AzivMGrIiGJJHdPe3CP1pW44GIZ8uOsCssDKe0oc8Is9W1qUdRk1xY2QBpsd3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993970; c=relaxed/simple;
	bh=XjQoRgda8BqxE/xsIHhPObHA+b7oTgnKQts29S3NmbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzsVg8YaE2Mw4Gvs+n5OqllG4v4cSxrS2giqT3o+nlTfb0bGmgxgmB1N8PKZQUK0aCPEejAFrSGnaKgkNWlDa5vfHnfaOED08IGs23n7lbZGo/l/sfCL9vBu4CsURJleZFj1kU6CfcWADRxJaf9gdK8qY/quWhSsQq73B57P+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqsAxS1r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqsAxS1r"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so1274779a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 07 Nov 2024 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730993964; x=1731598764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S1ojgGMe04oTpXQ5H/CMjh7ambNOZIyTDE3vys0YK64=;
        b=XqsAxS1rfCyW8Lu+X48Iwb4sznwbBEykddsv9WBjHAOqB4lZT+8ZKOJg90cqctbsUE
         WEc1tdxv32bAai8EwryxfR61r2Se3f+FGnl1UtJ3DOqqUE+TXu4gs7yo7pckYgZKN2Oi
         FR4r4bNqHCWF26epGL+hHfkPWk/VOk+nYM28rVkxU+eIZGoEI/NtJQETcxzIJH2dF0gv
         MhVV9LdMBH7W/3gJ9/8ihf4S6G7uW3mc63BxFkUeHLOBCWAEAwqj1WUurNWe8BvhxS/J
         niH1NkmBXwsizMQ8QlZq8+A0cO1Jyc3MB227939gIhY/24zZcNNesi95DRTYx/2hsTsj
         ozMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993964; x=1731598764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1ojgGMe04oTpXQ5H/CMjh7ambNOZIyTDE3vys0YK64=;
        b=QqftXNyDz3AYOT+FV0PmwsscKSaGLlBHdIBa/m4oqGhegjSOd37qxYlrPO4HXd+ly0
         1qz0BXW1qKOZ3jLJN7C9H19NckpIlwiiPzNjjYEFojEvOEvUTaEkC5SwVwR7GULqTuZw
         VgwpCqeLaxTLf5pUiIVJq7pwDkBFN1hVN0xPKZo/wc35sInXWAmddBq81zKVsqIwzidw
         WCOHrsQdfFNxNHn44nPBuZI8o1O1cg/Z2SrktvlyG3E6jJQ7zM2QgWRnIVMedPbEvkgs
         5RDt2ddWKpbdg+AIWBB6//UcrEMPD976WDZEji3UW+UwfQ7iXyD7kOWMhO7RwmbvrKXe
         pL0Q==
X-Gm-Message-State: AOJu0YwC9sBsUgFzIixG0M8N4vgeL7M+yS+IXa3rjPYnEHOUXq9lhA/M
	4jWgK5FbH/pB3tZvD0p2iFnF0IHTvdGj2YnlONkBzplhU+ty3O0sgD82A1TVywTMtKn87Vltjpp
	E9KviCWqElbcPlwtDO41yZWNPRWa3mxDfE2jSvg==
X-Google-Smtp-Source: AGHT+IGXOrtkRVrCYc75d33lyAV/3LiQk52p2PPpTahHjZKRW22P6Mji6/gzk/OmarJ3qb3dvfOp40D+9g82vg9Bxz4=
X-Received: by 2002:a05:6402:42c9:b0:5ce:fa29:5938 with SMTP id
 4fb4d7f45d1cf-5cefa295c74mr3861608a12.8.1730993964398; Thu, 07 Nov 2024
 07:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com> <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
In-Reply-To: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 15:39:13 +0000
Message-ID: <CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond end
 of target attributes
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, 
	Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 13:43, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>
> In cmd_features_set_feature() the an offset + data size schemed
> is used to allow for large features.  Ensure this does not write
> beyond the end fo the buffers used to accumulate the full feature
> attribute set.
>
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a40d81219c..078782e8b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>
>          ps_set_feature = (void *)payload_in;
>          ps_write_attrs = &ps_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }

Coverity complains about this code (CID 1564900, 1564901).
Essentially it does not like that this check permits
the memcpy for the case where hdr->offset is 2 and
bytes_to_copy is 0, because memcpy(invalid_dest, src, 0)
is still UB even though you might logically expect it
to do nothing.

>          memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
>                 ps_write_attrs,
>                 bytes_to_copy);

> @@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>
>          ecs_set_feature = (void *)payload_in;
>          ecs_write_attrs = ecs_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->ecs_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>          memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
>                 ecs_write_attrs,
>                 bytes_to_copy);

Similarly here.

thanks
-- PMM
