Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897921D63D6
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842676; cv=none; b=uuC71rEik8RTpBfGLwZVHIft/OgVRNmeh3ZgwDhIxuNtzOBK5OE8RqaMsKVhCWdepn6yorzolO3tI2VLvhbvKDZm1eKh00MGE/01jp4eV7WBnWuNV45X11F6Bu/91nE4HYXwy9OBz99Z8kZ1DDisUUOPbgzw7zH7qXEGDH4KH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842676; c=relaxed/simple;
	bh=R8hdW4vIduDcMUDO7UkIsZQ8HvT78cQQzsa9Bvkdd+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE92f+QbkAvYvJ4S0ARMGMM5zp//lldW7pVrlr6jHtsqTCQ+v2jeJ3WOKmpKuLDPKYOM9ZaFWgGOV0exZqB9mA88VHH1ZnMSycxTe6yxac0XoOMo4Ik7ZOBMKiMNrhUPwsVbcOjXmzIgl49BqqNMUu7AxT3qzKVZYqn3RuYXQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chAaO1rs; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chAaO1rs"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3c3da5bcdso55105777b3.2
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730842673; x=1731447473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfVTQCmMouuqtILwXS/kTUubRKXoIRL+2su4vKaPwvY=;
        b=chAaO1rsyUrHUlObBJNotV0CEMp0+rEKan1WDN44m2GJe8TQxh4p5n42GD34I3XwzL
         ALqrJ5mM0m7mszrWJ2/Y98BLsrDGdV6fwnIzyor0baHFXjGRPBx1wFp94riMldR8nm44
         9Ym9UuQVBeE0ToyTbWDqh/Y2UpFHHoSDrGoKbE0FTaYpyng1oqOoZbf19uSdMWmb9Kx1
         K7wUfsH6px197ukPS13Vu+0UyGdx5ZpQRju7opnBTPUQLr/pxO+jtEFJv18yVc9GPIrI
         S7cE027jo9uvDzHP3CD3ihexIvUcRx7tJ1Kih5ZUGUHiG9LK++Ky7dHznLA1LerQ3bWA
         rRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842673; x=1731447473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfVTQCmMouuqtILwXS/kTUubRKXoIRL+2su4vKaPwvY=;
        b=ahkpkBKi+uuBPqoaz/yhI44CFds56VjYR5HMDX3hbxDLigT8dFSJB/BkKG1wJZxZso
         MBwo/E/XJpcZShDQmqlBX924twvWMvb6tseC5W5tHENqd91EKUYE93UcxecO5arw6X2+
         +f0VZvDWD98VxA7A93Q6r2JXH89kqzJGCpgzZ8a/iFyMNhVYLgbAE219h7xp3uo/Lv8V
         BjUBMAybAK859i6bOPLeyNDaqFh7KGmMJ6RESTd/ZCanckjV+1P3uYyH4VGbPITruVNB
         Bc6KZ8PWrxpe+Gjo6oG6WH0lDnmvmVK3da4jp3PtpZwWRXYgUWzM+6ZNzA6YizvKBqO+
         LmKg==
X-Gm-Message-State: AOJu0YwwwYm1LghKbfO7hi5CkRGWjRVXI4+njlc6X7olqTeLCDI4oJub
	qUoP7Lc8H8aSjnuuyQSSYcBewEyVjs0ZP/dERXQYRP/72GanyfOr
X-Google-Smtp-Source: AGHT+IFLaglPhrw++ZguAUgwYQrvQv/21EPC2m3ciNiq6mzQ3dpQQ67vSy2ldIPvo9wgWJlD7HWGwA==
X-Received: by 2002:a05:690c:608a:b0:6ea:86b6:f703 with SMTP id 00721157ae682-6ea86b6fa7emr105413097b3.1.1730842673522;
        Tue, 05 Nov 2024 13:37:53 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea94102de3sm12224947b3.52.2024.11.05.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:37:53 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:37:50 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 10/10] hw/cxl: Ensure there is enough data to read
 the input header in cmd_get_physical_port_state()
Message-ID: <ZyqQLoCnYMDhBmTG@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-11-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-11-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:17PM +0000, Jonathan Cameron wrote:
> If len_in is smaller than the header length then the accessing the
> number of ports will result in an out of bounds access.
> Add a check to avoid this.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f4a436e172..2d4d62c454 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -530,6 +530,9 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>      in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>      out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>      /* Check if what was requested can fit */
>      if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
>          return CXL_MBOX_INVALID_INPUT;
> -- 
> 2.43.0
> 

-- 
Fan Ni
