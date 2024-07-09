Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540714D2AB
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517525; cv=none; b=SQaSOaPir0K3gQqNL9x0cWEiGw+gnxqNmHeUoJJYX8GPXZc7QFXm1eqphSYT70dD0P5KCdg25vjD/GYdnq0KRJZZtj0CpWDkEZ8IQX9UVY7buYBbz2dc8GbIKPUEPtcBncrQG/51jr33VTypMLBTJgANBhy906K1M8aMA62KXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517525; c=relaxed/simple;
	bh=3mXKb1+knItv/RtaKpfs//ZAYpMupLlXyOK3WNyOufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N09T3r+eVyhobFBIJNgGM4qpHScDa8cmM+7wYD++ONZ72/ZD+N/muoKoWo5QcCCpnx/XhuanZR3+nxClYba2at1nkZ/zNAiD8OSoWadOOhK6CkdsGU4VlATq2feAW8aQCz7k9WrSxCnC+aHRWAQhIpTV1kiTA1gp09SJrs+H+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2Gxf7Z+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Gxf7Z+"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03c6892e31so4576751276.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jul 2024 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720517523; x=1721122323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFbI0eXuU+3N+siSsIHyXx6zMuPHmoMBHk2P9BoQkeA=;
        b=W2Gxf7Z+R0VrXslUwxDc2Jr7oVSjWde9OxquTR4NBpFjVf5RK7VNf4VAvfOW4mvmLZ
         EDv7Akafvamcd1sPXKH/+umM4yefzZBqKJVHYJdFePs+DqE+Xz/OSXMe8MXphki8VpD2
         1G4oyuLLVH1cASntZiXHKUOMKl4ETEB/9LZBg6fXsOxgoRHIVBzAW2XU+YyultEA4rYS
         +5Qx1VJVVAzsJtP0l73dBEj35Jpx2NNbkF+wWMI/I51kDF9PlvH1QqyGh5CcVWFfbS5r
         HqubXnliUwYIMa+SaBjeiCNFZ/J6XN2+0NV8PCL/BoPev+kkj3rwBXzTmrpEkNKlatqt
         ykVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720517523; x=1721122323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFbI0eXuU+3N+siSsIHyXx6zMuPHmoMBHk2P9BoQkeA=;
        b=rvcb/cqlIJhMnfpSVaV7Vi6YCbIawerWUVWyrIz3Y2K3sn1UK5VwrLr4Rif/Zahgw8
         e59BobPD638KBilUD+W3OqGzV2Ege8GzxcZi45dn/5GvHaO5lNVo12W0XthHjT9GxfDu
         s6dldm+xohK6Ucfd+GBuTkljyjEp3K4QsFokwntd1DykwCIIAOMjYXQb/jVFZCGtj7e9
         BmEK3bq3WQ+ZhD0o6BQXCOWdb4u7E7Br/Ojqcj0ILAD7u76BhVx7xdrM7+AsxPArAfin
         64C1kzVwmfDIkUeSJDPF7YcMFObE+35b1JcgpJFLdwTgk4o70breqvPRWnk5demHI4SY
         pd4g==
X-Gm-Message-State: AOJu0YyGBQ4uySO7R9zCyUgSlZCxlFIVJjN+kDK3zDjzh1ZgrOxtDpn0
	IKbLnFSS9cop+R1UOfYVIVLQ3xo1k/UfzvDOgndoP1ECCFV+ixKrV8rRLNlHPgzrjlnwCvpTZJ+
	VHkby7Cqw4cK9kMLjky1LFnxDz+oQ1j7pCqLqRg==
X-Google-Smtp-Source: AGHT+IE92SutnR1o7Ozw4MQxiEw2Vr0nnnM+nKfnyMjW2lChchcD4mevNq28vRkFdry0g9IxFlrK+TGy3NQhZg4U9Fk=
X-Received: by 2002:a25:a345:0:b0:e03:a60f:4f98 with SMTP id
 3f1490d57ef6-e041b03d10emr2139957276.1.1720517523129; Tue, 09 Jul 2024
 02:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozTTpbMjff82vO0@infradead.org> <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
 <ZozoWwm2v246szTu@infradead.org>
In-Reply-To: <ZozoWwm2v246szTu@infradead.org>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Tue, 9 Jul 2024 17:31:27 +0800
Message-ID: <CALX8JfS5kpY4P0r3QUmDxwoST=d3yR8gzmxK6NSyXr6bRiBo7g@mail.gmail.com>
Subject: Re: Is there any plan to support CXL GPF in Linux
To: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Christoph,

I agree with you.
cxl pmem device should process the GPF event well by itself which is sent
from Host or Switch.

Dear Dan,

ACPI.FADT.PERSISTENT_CPU_CACHES flag is not recognized by Linux.
Does it mean "cxl pmem flush operations reference the NFIT Platform
Capabilities"? Or, support the flag and cap in the future.

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:35=E5=86=99=E9=81=93=EF=BC=9A

>
> On Tue, Jul 09, 2024 at 03:22:53PM +0800, Yee Li wrote:
> > As I know, for cxl pmem, the DRAM cache is very large (even equal to
> > NAND flash). The data is stored in the DRAM cache. Data sync during
> > power loss or some sync operations. Data is stored in the DRAM cache
> > for most of the time.
>
> If the device can't provide enough power on it's own to take care of
> the DRAM flushing then it's simply broken.  All these details are
> something the manufacturer needs to take care off.
>
