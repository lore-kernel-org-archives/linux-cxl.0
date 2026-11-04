Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793772535;
	b=2QbjRYCjhI1W43tQkkUu3JKgeWPo/OnBte+nCCKArJoaA5oWwYIZr7jV4DPlL9dhjIB0
	 h97nxJeajjKLMNrlbwDftiOt+Dw8kX5rlDDCgTDfaIO3Ps+7yemBkFlDmr+YgzQBjam3e
	 2IKlherIxW4z9LLJCyIihDbjh4ZyQ4fzFbuTkh/UoRojWFOri/w3mBmw8M0SPoo4sww1x
	 LHdKtKr9ay4OtX+OSpi1EHm1WhJeBjortSpMzj5qosICihR8lWqjM33mFZvWLjNtyTXRz
	 /zgREj1EVbyRbJjmJTlWfoqVo1tNbnRz/B2u0ecJrnZZ3mXH8atc904tZaSStx/FhRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
	b=5N81oX+CQR7wOBL86jFtZ5Y6xt0+Gmc3xciIIbJJxJ4aKsKDLkIinD+GV45/ItmNssuf
	 7t1cTvWsSrcCHYHnQ17HlHKECLQMAlRR60iR3HSxaG5V2iwZdIifc2xg20A4+k5qWo1U6
	 VfEZG2PcVNf1NbgyHcbPq1Wea+I4uzpSMHuUX7SxmV1YcIWahe2i/cyA4n+7/WX6jl8JK
	 ChhuoIFH1R0+QDa0dTxB5DJsz42TAnhtH/mGqyCvU4Y4kd/5x+BwpqxvrLoSwVRsS2mgM
	 BRqPp5B58cmEpDwStfO8prxDE2M7GxTLRUqb2/+ePXH0H3RL7VD42EVa56XuqFWfElA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLmgJ8sw;
	arc=fail smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36333606A328
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 06:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36333606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLmgJ8sw
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so466252a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Nov 2026 22:08:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793772533; cv=none;
        d=google.com; s=arc-20260327;
        b=mA6AQMc8zd1V0Fgr0i0bFbbUfXUu14yNaac2fLPrMtySgnlAJA2H0Q2s0L85y09+gP
         2qqnhuoKYHpe8dTeRes5XRMV7c8AjeruMVImzrSXj/Kr9FPu/PYOCN/L1JcEIipcOUBQ
         xg+1oHl9otcYyfZOvG5TagVpUhQFAWhSLAwUID4OkwjlaxQpNNXiExZg31M746aElqxG
         XARAganhsebBhUps9ilLubmgYpr394AZGRfbdVRIjMfXDiFI5CO/Qd1P6ru26hWBBlUS
         9PVb9YliSVvc0WQoPaEghhBKPRdoaCKXQg+kT+U9/E3Th4d1c4xrYMsRDtZ6aT2sXa3P
         IkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        fh=ilSMRhkb/aiKFRmJI4Ri1ml76boCyc8Ev6PPvQQ8fXY=;
        b=hAjxfgR12vuUfRXukDDQn57vVSMSk/4RhjuODbOnfMoZahbAyLhEKPs8Ku7UlmNEJW
         MnFJmEODdehsrRKRMHnh8f1l9o0lcKe2GpYBR4nq9TrjgSJP1+a/AJtVp+HHjK8g+LPT
         aPhIajTcaGPIQT1yjU7KoFjtTpEUml5Y9A36tZc8Rm4Y3m0fE5w6cxfgrY3MlB6H128P
         wE2xLer6QIcVS0rt46acsh6Ke5VdLRbpMy1en3XSV+Bi/Qw2/h0iudFPFpwXmUfAZ8Eh
         eETzRz/BOnXbFIaDan8fQAP5AyaocLjhze7KmlEQbpZ6Wudxlnlmv8uvXUPNNT3DsIt0
         t1GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793772533; x=1794377333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        b=jLmgJ8swYkdf0IbRypo70hgc+XnzvV95AGf9zO24fj6Q0uAZt8QCX41OrrIl7c6A2Z
         noHBrpPEAOSTyghP0T/2Kjbj/BmvQoLjlltBRDKVoVhgdNNSlF+VhqVgl1nJUDF5og4P
         aiJb0wB1a5mhTv2aa/gMtoBpbaOf/F/X73AFZlMRhjPlu2T1SzzxTCoI+yy2ULhbYENe
         jo+/FZgh22tcl7RgXsGlsKiwDNuS09GVzknyMkzhxAdWeUtJ/q9ALzF7K1AKSTEppjmZ
         c9gGmrx2HDo2yxaHW1ULR6pUgL1y2x14xx0JoexDA604AurzkrJbR6d4r+Gb2yD7ASyP
         tDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793772533; x=1794377333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        b=zHvqtt8KjqHtsN5NPr+VSiJ16b22ASgtw5hzN2EdexJiYdsOlAS6wvL1tMFdcAZzg7
         91qWRSdGEFRqjCVQY5omD1cAbvriHrxEzmIdoIy2o5HMMfiYz/wLAS95QNRopOLfwyvf
         DDZJ0JpO7YufpuBPRZ866GzvuOQ6iFMvi39fVgYRuyZ0dZf+hYnShbnFzPwtZOEEQJmm
         xz7QukOqJiS9m7KD7jadSqH+ocQ/igsQshlxvZ25lz9/fbqFSzho56azkodXnKwCzF6u
         SWuYwMK322Co0RZu3JPqpJM8dUgG+Qnr6kzGTdscC+KcPSIhrIkpaIJ7sGa8slz5OJ2R
         fgvw==
X-Forwarded-Encrypted: i=1; AKwUvBxiN5WUZWPG/NDF5OoAk+UrcluCapDonU1YBb5nTplPOMSbVNxtkAnbJ9e3aNAqfrrbygjxnVGfVPQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vtzEsarg8qNb/WGUa7YNqQQ1PrENh1J6NW7YF8/WwGSCFJXzI
	VECvw2/HHcQbDyy6zSTXJt+fkLu/CK12C7uZQj4m30LWdNiMdaXrr4XsiMRXnAVbip23BuAu3Jb
	TapMbHX01G1HZhG7Ij+TfUrhTshecRaM=
X-Gm-Gg: AYBFou35PCv3uYDEP2S/f1+3nJmAGaKlfA1CNxfuq9cFqNscGvwevbCTfLpdqP6d9/k
	7rep3kfXwVTwaX4gvPhwIBhxM4yTCA2D/wsh57ljc/gkgKX59g2VOPwnM21WxkfN8SlKa4v3ysP
	CHqYp+5+mDQ06HF49zFUkrn0EGzdvMq5NKEjiwjpq+9dzUOmKy1CVaHcBdzTFO3LSoo6Qy53Ty0
	3jEmkiT4GB6ffLhZYAEsNXLAJN/0v/WXhjTH8KlOgllBLhWw1Pt7fJSsLXBpm+19Ftohv1IYdJB
	dv4aoA0BOCL80XN3z12U40I6vmmRtKXR02wz942IKDZFbAUycV8nhuwlzZ7CJ+E+TYhT/bqIuBa
	JqTpWY5zP11WXnqeE3CVwddspOl1xb1wUYDd8zknKMR9gMUlcJQ66Pbozk7356YKI5M45aG79mm
	m+U1O0vAFtV/fIWw==
X-Received: by 2002:aa7:c259:0:b0:6b4:2638:8ef7 with SMTP id
 4fb4d7f45d1cf-6b4d468226emr8448814a12.23.1793772533397; Tue, 03 Nov 2026
 22:08:53 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com> <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
 <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
 <DM58HRC3DHSS.1YC0E53ZXANT4@nvidia.com> <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
 <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com> <DMHAUFW5V16R.20XEO2QDXIGGG@nvidia.com>
In-Reply-To: <DMHAUFW5V16R.20XEO2QDXIGGG@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Nov 2026 16:08:26 +1000
X-Gm-Features: AclHuK8yY3BZ4pKP3zSAvQ1_8YS2crIm1mKvYKw4mutZUrcwZsReUT8BFmZzmzw
Message-ID: <CAKmqyKOLSAFZNNhLH7hTVuTRs0Mb17jsbrjsesDWaN7CoN5dNQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	gregkh@linuxfoundation.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:52=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Tue Oct 27, 2026 at 10:19 PM JST, Miguel Ojeda wrote:
> > On Tue, Oct 27, 2026 at 5:19=E2=80=AFAM Alistair Francis <alistair23@gm=
ail.com> wrote:
> >>
> >> That was kind of the goal with `SpdmState`. The issue is all of the
> >> drivers calling this (PCIe, NVMe, SATA and SCSI) are C drivers and
> >> won't be Rust for the foreseeable future. So there aren't any Rust
> >> users.
> >>
> >> I have improved things a lot with v5, let me know if you still want a
> >> Rust API. It just feels a bit silly to add one that will probably
> >> never be used.
> >
> > I mean, it is true that we don't want dead code, but in general we
> > would also want more Rust callers in the future -- so I guess it
> > depends on that "probably" you mention, i.e. how likely it is. So
> > could you please elaborate? i.e. why is it that you don't expect
> > future Rust callers? Would the NVMe Rust driver want to use this
> > eventually if merged? (Cc'ing Andreas)

You guys might have a better understanding them me.

For SPDM to work over a transport that transport needs a DMTF spec. So
right now SPDM will only work over PCIe, MCTP, NVMe/SCSI/ATA or TCP.

From my (limited) understanding of the kernel's MCTP subsystem, SPDM
isn't going to happen in the kernel. I don't think there is a need for
TCP support either.

So that just leaves us with PCIe and the storage bindings. Both PCIe
and the storage transports have old well established C support in the
kernel. So those would need a Rust implementation to use the Rust API
for SPDM.

The NVMe Rust driver could use this! But that would have to be
accepted upstream first. From my outside view I thought that was still
a ways off.

>
> Yeah the "probably never be used" part sounds a bit strong to me, unless
> there is a reason I missed for why no Rust driver would ever want to use
> SPDM.

The "probably never be used" comes from having a Rust
re-implementation of PCIe or a storage driver.

>
> Regardless of that, I think it still makes sense to have a layered API
> design where the (necessarily unsafe) C API builds on top of a safe Rust
> API that enforces the invariants and other rules you want to uphold.
> That makes the invariants that C callers need to uphold manually clear,
> and avoids having C-isms in the Rust code (like we had with the crypto
> APIs calls in v4). Not to mention my favorite: it makes things easier to
> review. :)

Ok, I'll add a Rust API then

Alistair
