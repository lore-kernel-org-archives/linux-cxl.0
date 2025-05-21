Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E61BCA0E
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862567; cv=none; b=pDv2GEaFYWBgSC+byeXUT++e5zkqJUy8bytZUnTK/befSA4Lpc3OGjhaBuOyNwLmDDEEht/t/iFGKk0KJJIp3XjleF3fWyVqtD4la+nmy901P1K55nJMEHJcuSn1FsLpvFdv7zrlLIkmIf73G8pDwdYsfehReC8gaQXKSW++7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862567; c=relaxed/simple;
	bh=v8T8IXJv34w5GhCoDFm92UIJduiC/zsG/e7Lf0sZnTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onOj4MDwwTurKgUYFLVMdxKUZ0Zu7ys9sztsLFiyuXQceVnXGXOolC91GjnJytlK5A15dEN4uPIEkRX76ayNhYZ+xR/QBSO4tYGG8MtJc/HpL72mugVWCzHfm98+C2zvml5TcKM58Bw3lBZ5vlGoAgfP8Gl70QkVYfMjQXNbSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zto0RnMT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zto0RnMT"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-601a5747638so7828044a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747862564; x=1748467364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UzGCJIU2cQwcC7+iiIjErAYBye7KHMwRM+ix5JXg7rY=;
        b=Zto0RnMTFhmVtu3GGIpIBioAsEiZP5HkXvdwLTkFKG/EIS7WQ+VNQw8qeVOoVRKeZO
         QtOCcX+4QOuQTrz4i+JkxemXAGuTD+tUWgr43GFXoZD09sI0pHbS4zcxghntmR+J/S2A
         5kMYiKz5B4WmbKkDyXSOFNOKkkBVeoZ1eTozqZWcUT3L7dq6Km9C1oJOLaIRMSeM1YH/
         zdxzIV0yS6D3yL/uJfXRAU7i8NZew3Z3rhUJ93Hdu/Y4BPKU2SpXi+0f4ldt/TU8QcFw
         fUuTNLkP3NMBPDEu+IV01BGgkO2Q33zTZTNT3RLd2Ih21XaNIshDQ6yYU7VWuqAT8kQi
         lKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747862564; x=1748467364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzGCJIU2cQwcC7+iiIjErAYBye7KHMwRM+ix5JXg7rY=;
        b=fVWxV/E+UdQAAJJVsbyYFlOoxgWmvEmVOZbOydgu+/tjqYlNYVM0BrR6o5N8sl2jwG
         JMIy6LiQHuWu8ttqDSA0CqZUy1Xd5Tw2QZkSQnEuBPQ4YRVRxVj30qad5Irhs0sCxFQf
         GYRMxrPu+lJgVul17qgxpJTn16ModS3cFTDGvJ/3Hk8VcNvzv536q2D/dHexBjJ8pJPn
         WWHteKylplMQGHhvkA17hI5LzzmxBusaKWvycrUpkILwXcYlCcYtp+6zvqj4ZJLBbVM+
         /jycG4b31oGDTLa4ijXTtzM1dwI1nWH8EadchIM3oe9WjqyzJ4yR52dOJxr9lOaQ7wLp
         lQPA==
X-Gm-Message-State: AOJu0YwVMww5lOboEkSpdhNUi1xeI2zWeR5U/CJKqEk3pKDvI59WX0gL
	vRjRq+ZYB93ItflfIvk/dT8gX0/Z+37t0cWEOjI14fnmfExdfHcYzgZDp//Izgcw+5H2VxbZNxK
	0avGHuxabf8ZSf1iFu8ACjCjoFziTOpwj6/tO
X-Gm-Gg: ASbGncspCMzFnQTusjx8xd/h1wVY34Nn4bNeLMfHsyt3YRk/shdCd8B3qMPeK8Fzx1Y
	/ov3DAb6xA8OiLmdgPPSaPv1ROJtY6s+gj7onrGghKhtC/OSPQQRxt9j75SRRGsM9BMPFZU13fy
	luzf4wBL48jmBqIknjC4F15B+DImSeMQeqJFU=
X-Google-Smtp-Source: AGHT+IGDC51f7e6qeJB9XVqfTVXIK7kUR4xaEy4uMrU1YwEjwlWNgxBudSQppU/C2Vv5ZTC7Ckwe9Oic7YT66CHLCWA=
X-Received: by 2002:a17:906:dc94:b0:ad2:4fa0:88cd with SMTP id
 a640c23a62f3a-ad52d4383edmr1768198066b.9.1747862563891; Wed, 21 May 2025
 14:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CExOgLYnVYdhHADBp4EEmDgfvhv81R1RW1iHGJZxd+V_1wSw@mail.gmail.com>
 <682bb71427ee2_1626e100f1@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <682bb71427ee2_1626e100f1@dwillia2-xfh.jf.intel.com.notmuch>
From: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>
Date: Wed, 21 May 2025 23:22:17 +0200
X-Gm-Features: AX0GCFu3HcPz6HKqO7OpsYr2seU9xybVagIoVFkeXOkRSzy1APJH_MQ9w3AE_9E
Message-ID: <CA+CExOjX2f5BOVu4bAGDRS11EwLevefJ7ziPHHUSK-hCFsZkPQ@mail.gmail.com>
Subject: Re: dax behavior on CXL 1.1 hosts
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, yiannis@zptcorp.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 00:56, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Yiannis Nikolakopoulos wrote:
> > Hi,
> >
> > I am trying to understand the dax behavior on CXL 1.1 hosts running
> > recent kernels and what is that I have probably misconfigured.
> > To my understanding this series [1] introduced some different
> > behavior, and I am trying to figure out what I am getting wrong here
> > (but of course I might as well be looking in a completely wrong
> > place).
> [..]
> > When running with Kernel 6.2.16 (or older) the dax device appears as
> > expected, and I can either map it or configure it as system ram. No
> > issues there.
> [..]
> > What is it that I am missing here?
>
> Starting around v6.3 the CXL subsystem started attempting to takeover
> dax device registration.
>
>     09d09e04d2fc cxl/dax: Create dax devices for CXL RAM regions
>
> I.e. instead of simply relying on memory-map information, "dax_hmem",
> let the CXL subsystem assemble a cxl_region which outputs a dax-device
> on the backend.
>
> The rationale for this is that a CXL Region enables RAS flows that raw
> memory map enumeration does not.
>
> The problem though is what happens when the CXL subsytem fails to parse
> the configuration. In that case you end up with neither a CXL Region, or
> the the original "raw" dax_hmem device.
Thanks a lot for the explanation, this helped! I would guess this is what must
be happening in my case given some failures I see in the logs.

>
> There has been a slow drip of fixes to get the CXL subsystem to
> understand all the various platform quirks contributing to CXL Region
> assembly failure. There is also efforts like this [1] in flight to
> attempt to recover dax operation after a Region assembly failure.
Interesting, I will keep an eye on this and test the next version.
>
> Until then, the workaround is to disable the cxl_acpi driver from
> loading. When cxl_acpi is disabled, dax_hmem proceeds to produce a raw
> dax device. That configuration forfeits all the RAS support, but that is
> to be expected when the CXL subsystem needs help to parse the system
> topology.
Indeed the workaround works as expected, thank you very much for that.

Nevertheless, if figuring out the quirks of this platform provides any value to
the core driver and the community here, I can find some time within the next
couple of weeks to debug and delve deeper. I can of course give more details
on the platform, logs etc.

Thanks again for the help.
/Yiannis

>
> [1]: http://lore.kernel.org/20250403183315.286710-1-terry.bowman@amd.com
