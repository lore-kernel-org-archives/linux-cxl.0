Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB912E40
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnTQA7tu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42497BD
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 02:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699351708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eftHBmFdQ6rCY7P02LDmKGBkG1Er/ZcvebyCL7XFRyw=;
	b=WnTQA7tuqk+IofX4/05R7ZeK0fRHZfuAwweYOLa35TGwWErYFyS1QvCbbC4bYCxVlHIJ+U
	9oVsTpU+wJr2dqaaH3qBKjO5rnxRLild11QeSwzWJz3fheWIncs/V4YjBSKz0E7ZSx+BZ3
	bQ0bcb1r1pICvb0gm/jQZjeHTPn4yHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-BoWJsUumO-u0WG-C_0SaSQ-1; Tue, 07 Nov 2023 05:08:27 -0500
X-MC-Unique: BoWJsUumO-u0WG-C_0SaSQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083a670d25so36263525e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 02:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351706; x=1699956506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eftHBmFdQ6rCY7P02LDmKGBkG1Er/ZcvebyCL7XFRyw=;
        b=R8HobbO+Y2XOSgIX+uLyBYErp1S2uIW15SosmnNDorb5wdhSWPMfZJoyP01lR3yqXy
         iSFefSbG6ke3DmAAxKQnnssxYAbIW6F6CX4lFUjST/gBbtFTY5xWjOkAt95prxZZSPZu
         mJv48F+MpHIV+mVG1+vTNyXyFk5W3wGB/urkHVwqPFYrPpaPO20iKGAovlLHxZZpEhWC
         6q38GPg6Pi8m1Pc2zF/+es81+N0rXrHwnBgu8W5G6Ps4XEhFx2z2wQq012HPSuThOBzC
         t+vmXqlW2wmATexlagtvyQlaVjnD0v8AJV3cOcRsPtjXD986LeBRamBfEi33oc5ZRI9Q
         hM5Q==
X-Gm-Message-State: AOJu0Yx3htBIbosx/biwJmcr+6IKfiJf4gJG9Gi2j2+ZJc0FkyFBgAhU
	806B5If8gEpBNBjT5lbLqdr0y2nh5EosERn0CqhF6qXEQhuVeE/UNzj0z5tUGA8hbU+Ze2RrtFy
	SBEOLShtOT8/OVysM9G7P
X-Received: by 2002:a05:600c:1f90:b0:407:5b54:bb15 with SMTP id je16-20020a05600c1f9000b004075b54bb15mr1748401wmb.36.1699351705961;
        Tue, 07 Nov 2023 02:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtLvvy1lb4YCMN/4QbfcBgXk5ElDORFhwBd1qzQ7xW2AUcLs1B9deEPcqPa3/IRajDFO1cww==
X-Received: by 2002:a05:600c:1f90:b0:407:5b54:bb15 with SMTP id je16-20020a05600c1f9000b004075b54bb15mr1748388wmb.36.1699351705668;
        Tue, 07 Nov 2023 02:08:25 -0800 (PST)
Received: from redhat.com ([2.55.5.143])
        by smtp.gmail.com with ESMTPSA id v2-20020a05600c428200b0040303a9965asm14822459wmc.40.2023.11.07.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:08:24 -0800 (PST)
Date: Tue, 7 Nov 2023 05:08:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>, linuxarm@huawei.com,
	Fan Ni <fan.ni@samsung.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Gregory Price <gregory.price@memverge.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Klaus Jensen <its@irrelevant.dk>,
	Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2 00/17] QEMU: CXL mailbox rework and features (Part 1)
Message-ID: <20231107050731-mutt-send-email-mst@kernel.org>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> This series is focused on enabling the Fabric Management aspects of
> CXL to enable orchestration and tooling development and also
> to enable testing of related kernel features.

This would be a better subject than "CXL mailbox" then ;)

