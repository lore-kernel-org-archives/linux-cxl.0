Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD8385539
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162311; cv=none; b=K3lAUT4OLtUbUbGdeFeha4yOp/cAmG5TZFLapQT+V2EaAzBJSo7AWxyvnibWMwrxBginnUhjNEcBZk8Phq/EQegRxQEXSrdicqZHjmHezjHgDtQQes5eUmtaxCJqtdj6Mrj+tK8sN7NPWJUVd7wSIAf8PFMzPm52oCXDqRgq3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162311; c=relaxed/simple;
	bh=iU1w2PBEGsI8PmdYB/XkPgUOGXcYI0yADl9MtTbyDFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZDNDz/vHNSzmNKzN4MJOLmS0k94ZFc0fxgRfjaUKZVm6o5Vik2U50RCCNHwoLkz9cJ/kDhw0CbX/3jgZEzaCLm9sX7LR7nhnMooD5HaZXseRdZVJI6JLHkIK2mma2s/HepC8Sko82lN2m3y1XxSpcH3WiNHmiDNOpRHZ/CG5YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSDaZLlb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSDaZLlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785162308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7VzblEml9Z5dIxjHzOxhK5vkTx7quxbYMHxe0etLbE=;
	b=eSDaZLlbwPAJYIUdtTHETXw/kw7KXQ8lXIAAxxV1VMB1mrLphKabX0pBWGYxIQBbOeWQvA
	0XrgcVgwW7JcrODgNSQ9ynEAyl7NXafgLkM+l01ZPT2PCqgWycdQdnS/5kgeB0jQJcSNaX
	CDDS4sWhpqp2rpwl26Wxr4Y2WFOxuJo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-iZO8tQwROO2E1cy_Gn5YWw-1; Mon, 27 Jul 2026 10:25:04 -0400
X-MC-Unique: iZO8tQwROO2E1cy_Gn5YWw-1
X-Mimecast-MFC-AGG-ID: iZO8tQwROO2E1cy_Gn5YWw_1785162304
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-977924174f6so590445241.0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162304; x=1785767104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7VzblEml9Z5dIxjHzOxhK5vkTx7quxbYMHxe0etLbE=;
        b=QuMeMalay+mKJ9FZ3J4falECbIT0bA44O0BxuWeWI6YPFLlEd5B+KascagAs2wguvB
         25PpCsyxk4uYinIdPL3axwD/nk+kRodtFEI2SFERlB+RwSEC6ssxEAqQI5a7NUsWo6cN
         rOZpAr7AzePVdlQfBW1GBss8+mB9DIFgrZa0whB1s8eXaccWKQrGP0XANiC+vQQoxCPc
         ozgyRE36hiH7MmLbX/DGluZHJfqgQs86uP1f/b6/8aAhBktequmvwzyXDBQ1B4/rWh1U
         xHCwhJB24dK4Y8xeSz2NvxBn0tJWcp87WrF15Kit+m8Dseb3Hopnanx5BqSsKcWbJQwz
         de+A==
X-Forwarded-Encrypted: i=1; AHgh+RoHrBAa7adFPvto83TrZQHtwsUlbxbHA+Dxyd0BUuBSaC1cpApFRCdW8q3VaM5xooJfjOKUZNRmkTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8THVQBcckRkkhJX/9mwsH489ND3B8LbYALX+smTfDUAgGECAU
	c742962HjMKkeMbo6WNRgO6PXn8J44gY451R/NMuv9dBaql8oxbNfMPXqQgqBRRjStwhNWIVeVM
	N1Hx+OLg0a97BUtMEntUIplQ9vQ2XVgguhl7CXRX3nTXXWaKZ3rK+NVgtmvcpd8QGTdfVow==
X-Gm-Gg: AR+sD11nHNuXImRxXYTw1TuD7aOeZub63Z0TAxks275wGlvEd83kKkRE198/VU0pDMx
	NVftzB9HuDmatzWSf5bHzv430FQyBPTx29dvM6UkYIOYc+Z1MKjSlDTHAxYIVGz2H1hrZH1VKui
	Jz/USEULi+lwkfc2+8Is8xmaoOam1u0PjTT2Bf5r7ljxUYfrchorjjJSmnOMvvzvskW1Vm8/Ulg
	vdXiec9EV5qVhm1EZyOvHY47pzPGX+UOVPQwLJM9VKugrlC5VoJb7dJ0WEiNz+zoBfG+dJwMGDB
	MU2bUIBXLMuq7UpNvbav4F6jbTHmEaylrdNS4zEg97jVrN5mxnNc9jSgjvXwR6qZh90Udt3O
X-Received: by 2002:a05:6102:2150:b0:74c:8ba2:3e90 with SMTP id ada2fe7eead31-74f9d08d0a9mr4042703137.3.1785162304183;
        Mon, 27 Jul 2026 07:25:04 -0700 (PDT)
X-Received: by 2002:a05:6102:2150:b0:74c:8ba2:3e90 with SMTP id ada2fe7eead31-74f9d08d0a9mr4042686137.3.1785162303735;
        Mon, 27 Jul 2026 07:25:03 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c21:6818:c87e:c65f:8297:5636])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75033d6a692sm5507243137.1.2026.07.27.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:25:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:24:59 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 11/12] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
Message-ID: <amdqOwtJi-6UTbgw@x1.local>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QaesxlpdiaFfxCPeaMb7fl9uHDsE9EQ_S9PFdt4DdZw_1785162304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 12:44:10AM +0400, Marc-André Lureau wrote:
> If err != NULL, free it.
> 
> Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

