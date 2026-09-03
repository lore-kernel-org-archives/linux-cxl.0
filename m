Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB964BAA10
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446716; cv=none; b=C/ZXV69Y4CBmEC03BhX/imsWlntP+cAPZZpqLe/UwOZnEnZLx3JgXdGTisuneyueO6JaZ6QXigX4OQYNSKhKwfzvgL6GwKqKu9WHiFukufWHTjtxQQj2eSTGRMNgnWq2qundfr/mhJXlURVzAJvoUS6yEvK7tkuw97iWESC/vBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446716; c=relaxed/simple;
	bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n18WMR4B6847g8mE0QPcbIwEZ+Q3XmZD5U3AsEqW3PpLS/uNAEojRoSRv8CY3jkZZq6JluWnNfJg3Ov3OulCAqRbFzQVKvjyd8jTvq+joJRXm7YzfoqGgNv/aDcH3AezAzDCH1eonrepSCr8FS7NPa1nKK6y3lVld7Ov2hT2Qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2LD023l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2LD023l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788446713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
	b=X2LD023lXgqInvbQV3q0e6yi23I0HAdYKfAOwOOGpKGOyS2i1ebfFD6AbFuL4YdyYccGce
	ujxrGNLnFmXGUVmVbsQEknTQYxMZ9pmfZ/PUEgcF6wSgIF6OOMtVoPHYoXV5LOKFvP2zQB
	E9LBlRJPOcRE925RVeHdCCNJqLYNFfU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-kGgp8gAWMTWq5rkroYWZgQ-1; Thu, 03 Sep 2026 10:45:12 -0400
X-MC-Unique: kGgp8gAWMTWq5rkroYWZgQ-1
X-Mimecast-MFC-AGG-ID: kGgp8gAWMTWq5rkroYWZgQ_1788446712
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66ce373dc9cso2621663d50.3
        for <linux-cxl@vger.kernel.org>; Thu, 03 Sep 2026 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446711; x=1789051511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3VYwHo6nqPsf+Z+thgv4+G2AnlQsXdSo/Hv4kwOmSE=;
        b=T0+l8HYKnHrhrT+1ba3YzdnSdsHYtn5nNrrAZjpf0h/qn+8RyV+G3Bv3QfXHJShhAo
         ZZHCEUfY3dc2xPHCJqDh/t61Ga+bMbINNXUzw50n7d32a0VpRxSp0ezPDi9dPLTlhya5
         ZtRBy78t+rW66OGxknNoLl4fy567ixFPjSG0Lh3a97oo2VK0cRCb4nDX9KZ1nOMh4hRC
         Y7WHgzRdQ1xt0BZetO+pb57tFTzcJyxw2eTGP77V8m8f7Hkizdia0c4oEcDouZzUZyNr
         OFawc9P7SfPruBO+RY1rhM2n0fFpyBv1uQDwML+bTC1oRF0LVFEW/JDZzJ5gXSmaY5Za
         IjmA==
X-Forwarded-Encrypted: i=1; AKwUvBzF+nGPJOn2rrZOIraXYUzJ9sESCuxfgWYKK5VYAzt6DTHnGuYDo/wlhOtYPmH0pKDXjLEhjTzM5dQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l/GJUWkJ9b4m9nZRlWrDMwrZA3gHnA1zmEUhXFh6MZPMaOqYOA
	Lc3uhHRp014PPg1xXk1Mjle9bvBwYTmWh8LKE1I1pBbiYC0Jt/ceZAOxIJr/Yscp5F/bVgBct+J
	3FBXMoN7Dii2znMbK5DhVjlz/bjKibRfUzxDvMNG6ayeo4k+rWepmWi4vb3efXhQD5M3B8u3CTQ
	o3kvxhARVpCp5CEb8+DYW6w5udIPEGsBA5dhfg
X-Gm-Gg: AYBFou1oEBXK7sarQdjqcLsLKAmEDRbKnRkI3WGL05WXr4zxO/W/Z5i56UoH7G89iGF
	acZ5a+i1Oa0tGxEIHN72Eht2SIowlaU67DoZDwyeKqCN3zdsd61AxzWpNi1ioYS3+aN4ElHFHAK
	7kwSm9gtR3N8TYqsSlGAFGHAHZPSJbBvwSHr0nywWsnvm4GsmgC+tV98uJUCLFcjlg+myy/93q3
	C/+TDBSQwpSvP6u
X-Received: by 2002:a05:690e:204e:b0:66f:9995:d0c6 with SMTP id 956f58d0204a3-66f9bd5cbbbmr3792476d50.25.1788446711583;
        Thu, 03 Sep 2026 07:45:11 -0700 (PDT)
X-Received: by 2002:a05:690e:204e:b0:66f:9995:d0c6 with SMTP id
 956f58d0204a3-66f9bd5cbbbmr3792296d50.25.1788446706362; Thu, 03 Sep 2026
 07:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901194324.458482-1-jsnow@redhat.com> <87ik4mr1dy.fsf@pond.sub.org>
In-Reply-To: <87ik4mr1dy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 3 Sep 2026 10:44:55 -0400
X-Gm-Features: AcwNN1VgNaN4xAvcs17DkNeBuR6R7xgxjHZ-filiFeIDSOm24eV2-6Sh2JVOWqg
Message-ID: <CAFn=p-ZkBrj0MNq=P3Myw5b1o-xUotm7qmGmuRzD=X_appS4VA@mail.gmail.com>
Subject: Re: [PATCH 00/12] qapi: convert simple command intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>, 
	Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CLzk-TK2mZTiBoGAnkl5nSDeFmzbiU7OahFdNqhjDRg_1788446712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Nice!

