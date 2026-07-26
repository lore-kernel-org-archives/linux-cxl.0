Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DA3346A8
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098953; cv=none; b=OXLnitF//vs9HmJjERSR1VwPX2OLpk00poyWV2sf82BHZMByshrzh/Gny+oul5K4m3mZnxclldMzt5IiNU9/EhkAs7M2W4TWB0Bro+YRMoz+1hQgOdCfzZYOm0oFevbh70+7myRWZ6VkqWBY5O5c1eFq4g67JYr489QKOKZwmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098953; c=relaxed/simple;
	bh=c4q+L+EK5NNYW0fS4MHk1BDOSaGgH+Ghtd/mifKq0rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YziBYzbzBMycx231UJkfoyc8lZDLlDwYuW+p3XRINegEcVNTNKjFup3oLzIdLBGyuqnQyD0ZO/Gdg52MbriXwAiK3icM6Rrr3PcloBttwdYfEy/XQ6TbyM9YO4UHVKln++Qp+peCLRfvTyGMIDwvFiza6CwhgOshplJfiToG688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wgv1kjzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wgv1kjzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRx8A7A/phIuHiTjk/0EnRV/DxmebmUEL531BmVt/oY=;
	b=Wgv1kjzhCi4RIZMMsXlxBgNddtk+IJCP4QAqOlSqrOnKoLcZhYHNcwPQzLlTQpy6hf5JCZ
	kefSFdndSJgz3quz+7tRv3z1MupT1Bi1iGvPrYqIHCGBTmStndisCoEgyWdxty4feTHg02
	zkPcJrEFBQHEAJl1mZ4g+QGMl5xAOXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-zycr8Jb4PD2THoNG7oUdjg-1; Sun, 26 Jul 2026 16:49:09 -0400
X-MC-Unique: zycr8Jb4PD2THoNG7oUdjg-1
X-Mimecast-MFC-AGG-ID: zycr8Jb4PD2THoNG7oUdjg_1785098948
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955e865174so11907105e9.3
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 13:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785098948; x=1785703748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SRx8A7A/phIuHiTjk/0EnRV/DxmebmUEL531BmVt/oY=;
        b=hLYGr2Srg+zFXEkzDCwi0o4gPTqN/14+ed/rSH/vRMzsP9fvXF4m6dHifuvcTJJngH
         3jQ/cJT5VQocIuuDWn3x3yMtDC9xau4lxzt4delmOLcDTCBqi1XCA4Ry2OCeFt4JPFrT
         bfNk6BSDRZdPZin4PLx0WnoX+gLPatsLrcWRKcZks5zVWqHGGqJl+LLN8uh7Od500hRD
         VJ1ACY/dlk0+fuDh6ustHCIeTGVKnnV0Sz+ahUJtl2OWHhSTdm2nf/xf++/SVoXIxWMy
         VZsI32dP/Si5HE1iK3LcsEW+clhlL74KY4moILsJRA/u1EJXXyEierltpAmBhJ2P0t8T
         +7fg==
X-Forwarded-Encrypted: i=1; AHgh+RqqvYNvIFRgXoTijslnKoQ0LDZG8sJR3C/L6iYFk7IaLBY8FkaMSnst7T1xEWi/l3qqwLvCFwJdwMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmbGqieruHlcjB0CM8Br/MiuXvfRGYn4KyfDcaP/6v0lJJndO
	aFpr9oWg+bM8RfhJeDrBooHoKv6Q8+MIILDfvCpFLhkyt2rdU7y+7P0ijp2i5EgiZ8TSLb8fbUO
	/O4QxK1yI8HXGHel0oQ4qdi1C3igxI+3+AZOIFqKo4Sm8xHI8OLJsB81044FNVw==
X-Gm-Gg: AR+sD11bYXkNd9vZRcjUSd53AbTlxHeQN/pAJdy6xLIWUWXVcUcvFrBoNrxFR6npIeo
	NSJ5EAjnHJ1a6n9fEo7hCWQUKoYktqYAFi8ydrnj+6NnAgHycdJrAX8gVErTrrf4DwJSeczju6f
	BpciKVJrU9VSqSY0iq+dLM3vEWR8C/ZCMZkNLHMm3vApmiDJ/0otcTHoswUulh64o9WWlw+R0xo
	Lp+df10OVPKj5HmS1FiZfaqkLg4FsjTrni4xY+1+B9feQ0WVMwxjNX2mJP1itH33D39yvc+Q94X
	7980QNvi9EdxtibSRDhA5+Hi/oY2HsC1XDcwAMwm8wNxWlKH/sua3j34oEeeSlCUu7ZVrE3lPpU
	9Up+jtF4aCLtE4ljRAuZjSg==
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id 5b1f17b1804b1-496b5747d8dmr85138035e9.22.1785098947901;
        Sun, 26 Jul 2026 13:49:07 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id 5b1f17b1804b1-496b5747d8dmr85137625e9.22.1785098947423;
        Sun, 26 Jul 2026 13:49:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a6e17sm161972635e9.13.2026.07.26.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:49:06 -0700 (PDT)
Date: Sun, 26 Jul 2026 16:49:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Message-ID: <20260726164738-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LDy0MdGHqklqJp1WuE6CShYpUmYtkmS-u9AonkwlExM_1785098948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Not commit log really?

> ---
>  hw/cxl/cxl-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 7e744312f1d8..eba13c9e7cba 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>      MemoryRegion *mr = NULL;
>      uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>      MemoryRegion *direct_mr;
> -    g_autofree char *direct_mr_name;
> +    g_autofree char *direct_mr_name = NULL;
>      unsigned int idx = state->hdm_decoder_idx;
>  
>      if (ct3d->hostvmem) {
> 
> -- 
> 2.55.0

