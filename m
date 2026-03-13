Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83817A2FB
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381327; cv=pass; b=H5fQq5rpF1lToRVRuZ5Is9z5KhcqTqVaXJkkmGeoIE2cXap3g8EyiVYwCSha9vi/3DOxcMlTqTG4jhTWaiCXKvs3ZpTCf8Jtu5QbQVF6czzDMb+t2Fm1g9rWZX1hmx+UyzPGyrJq6V1aLCaDha93tGRnJKMG3jZhnGZ221S5n5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381327; c=relaxed/simple;
	bh=zd0DFMoOUdpXYUPoqVp5qu2gOoi6hEJLHj0/NV4HW50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SemHVtjeR7KZJ+HCGhY1jor7n4YabMp25csdqA6dXPdFwsSmfaxu91Ehvy8LKtejmF4l+UtNJjuNSfU3M20pPSD2pMXiOLhzHPSZtKq0ysAG9n7o8eKPeq8W/WRuInp1qDhTqYmnbRxbwiNlJgsV/kMdZC44sfamS9L27WeEUJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh3jQZK/; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh3jQZK/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bda3b4318dso131156eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 22:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381325; cv=none;
        d=google.com; s=arc-20240605;
        b=PwdrcojkZ1oUw16uSW2YjKq1n6fg0g9daybR5czSXNkWdBJym1+kGlVgsf91Tt0BJd
         g40euFqRhxD385YHY9jak6PhcI348pc6IdMduyzD8/yD/1cJ6q63pRae6H4zr4sddjOe
         lsnr31IPBD73QDbqAJQ4dCVs4Lt1SmAWYDioVSiGpG6XUZs3ol6Ll2H/is48p06AMicB
         3bxfhGF4cl29P+YRxQojhl6hK9ApxBHqHaAp9bqghZomf6R48P+LrSBNPtU5Qu2ybbSI
         B3j3X4Z2It6kDj1+mxhZEyIpM51k5wibbHPff5lcJHYAnw6z3D9FwGBk0LJLoHD3X8cT
         f8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        fh=bZC5YXREUOuPPYG/yqUXYnW0CT4mjNyKxZfXRTSSNEQ=;
        b=U5QKDppTpHLrsRCeTNy1vmr+zsla7SbR+3EG+YO6L9tit+dB4Atj11yzwBtK4WE5a+
         m5CxS7gFg8U5Se1Vfo3zYZ7slVXi1sHts5f+2Gs15M/VZPs5UmBCGAyziiPA7gWxInPw
         UaQr2kh0m1n7COQJ08oqgcOnX9rO1pAiEKYhHkzp9jwM+fQZ7jGELG65/7S1bW2qvBZ1
         sArIEqKoiH/uvcyS0O7nVmytxU3P4TibvSYLnFnEjLBG/1Be/90hOtRDBVStBCbErNB9
         cBw+p211riwp9Cdxh85KtIBSYsRsOsS0T8GD6W63TBIDRSYubYEKEfLVvWhkQpr8P3Ao
         EJ6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381325; x=1773986125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        b=Rh3jQZK/obQr8YER4y/qTMe3TJUp6ucaI7awTxi5K1viEofft3w3OUOKUZkvTXZVs0
         SzWDvPs2u3gie/J/BrzBZPJF0BpcUH02ai2OiRR6u5A0JlGv0xzlKSpGg6r8ONxUBWun
         DabGLqMqcPSw4iOSFefSfM4cerByCeIG0Hi1PNpOS6esSgq9g/ysGiqLs/KVj0JLFKML
         GnfoMuueK+lDEdTGniJzx7nKKggYYYJwV5KD1n8tu8qpqFQImxn0pHjrE/I5cEtxCHv5
         hLa9Mt2F1lBeV/gq2c27xCRwcI3+OE3otcdeYn4lpPePAl1vLg2b6qVRwAmbttqEB5e9
         Ev5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381325; x=1773986125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        b=mVRGyFx8czy3LZEj+0S1UDAHn2JDD5xc+JkiEg4muMcQFrYWS37/vrgFR8l0O8Skzs
         8e3fk8ROTVWWoTEGJfnc1C2SgcglgcLqqag44TjXipZXeLkFNuaBGAKXrWNJfirFnmPy
         uY157c/bsSAqTn6l13WIZ1kkcDErJSJzHA7jO6ZK6mvavijPBE0/gQumxiljNI2wO6SF
         Ga3x0oleLK34lnurOCUk2l+BSoCI+61vPVDvnufibH+5reGbib50yVLTYtGmE5zHXKkr
         5aOeh1c9Iu3VxY1OfhlYbWaYsq5Iratoa5XkJaTaSwSOjvlQRCXJmzqB1bI+1uPbpTKn
         0dgA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBs4mFw7//g9Q1Nizy5/OCgVbAQP+T/kRpM0jD6WHnWSL2gfc7hTr7boZxrqGnUvYkNLUeI24uew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvREF3I5FHzbDP5s0EFQlXMFfAUmENqlVf3UJ3wDCMSrCPzbXb
	t+4OHFKggibD9gnyLEv85WAJozODkPvi3vp0g9OXOKukjitDl3RDHTGwF4MXCfbO/yUH/Ow6v9F
	v7GMeWkzn5ymJtL72I9NkGrn4OT+QXZk=
X-Gm-Gg: ATEYQzzbqxn09oMfJ/a6hLyLw/G/hBpzYjy3Y4yDYSMQ6z26dE+T9mU2Vt6UtuX4itp
	uSeEyGDLvKUc/ZAuujjv9hmvaK+v45rIOMb9QSrvKjjSszirvsC9ILR3VEQNLzbEVz3K1bHKybV
	5Bzu0wELwhzmQX5MRFizTX/Kz1HOXLWPDxi9J6S7+Cnh3eMOXW4XQFzDsx7LptsyjdkfUCYcwnb
	HdHeVx+VwjkBNXSid3NTD8Lt5JpZGtQ2Z2oBmgvyzFP5SMx7HcQuyL/Qfvq5pBJRIn1pLWBafUR
	VFu/2gyrqfxfHUaJdVgqwKnBtrU19ZHpHGkJGBXVHV622KCDPXrmhdJ42AJ3ssfiek1T0WJew/Z
	qE/v5ngQSSwRQwzz4pyHJv3Q=
X-Received: by 2002:a05:7300:fb88:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bea55f6aa0mr586120eec.5.1773381325426; Thu, 12 Mar 2026
 22:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-13-alistair.francis@wdc.com> <20260303113642.00005774@huawei.com>
 <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com> <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
In-Reply-To: <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Mar 2026 06:55:12 +0100
X-Gm-Features: AaiRm52a5-VzSErmrex9Pp1KfSZdHDvErZcjdkaddKkUtEe4EM-b4sQJQOaYYa8
Message-ID: <CANiq72=eHZSUraTVvysu-24sUqUSakWwQ3Z0xcYTLHEV1hKpRw@mail.gmail.com>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:53=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> We have `size_of`, `align_of` and so on in the prelude, so you can use
> those directly:
>
>   https://rust.docs.kernel.org/kernel/prelude/index.html

Sorry, I cut the quotes too much -- this was supposed to reply to the
`total_expected_size` part of the conversation.

Cheers,
Miguel
