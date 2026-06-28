Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D626ED2D
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661545; cv=pass; b=B+NzLVhvjSmu67f8F51CcGSifCkJPxF06iQ2MYhSFXrWgNlBxW+t5dBF7+zZqgVfrUs0pClAcpupEkMud8z2Vt7EEs5gW/qHLNi/Z5zG8gbDt7t2fLS+UTt9kWtZhsD0/w6BZXWCotsK+x3GRrThGsgVqai+nidLu+L60TyGOxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661545; c=relaxed/simple;
	bh=w2qzCKFrG19FjLt17SN7hSVzHqdC4wps9eEQlWGAd4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjXBb4qBNz3pU8+ad4dzvwmaj9chTqd9CEywL6nNvZVpRlfA7L0DS9AdXVT595ypwAcvErLVT+YRdURbUaL0G8Blo/AC8867XVVlsFeAucJl9mgvWc/3t0AWEReRJiTx4cSm1b1g2NY4kdgBLIgwFI36nBrAV7z8zpeIPMN55TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=cLUg5Uvq; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="cLUg5Uvq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad54546171so1541533e87.0
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 08:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782661542; cv=none;
        d=google.com; s=arc-20260327;
        b=FC0ywB5nRdQRRLn5BLmeC1+leb7QBtItPk+M7NE7NkvtELq00ixcjhOWw98s2pXpoJ
         JmSNtwlU2nbnuqmz3jM9oz5D5sgrLlE/uYmdHxI+tStM++hnQWvmDZYUE33fkdTHhKvs
         zK4owcjpCZUH8u01XmDnrOEU+0TwoTODjdS3+ijd1iruAX+H9OtY8mWJiOvmXYmPGENa
         vR2LugmRJh9MD0Q6TFIBvicX3LPqbh+WUM7HX5Fu4OCDg6ocB7h8hsmzpi3vBq/hK0Bw
         Ds2fRd1QB0JG/JZTGzcJev/+uY+CjjjIoHuAFLcdMngAvvnz9CXazLatN7ClaBeQhQc2
         q4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAv9lBpwJ9ygLTg/j3vYZQS+xwu0/dkisJeUZL+Xgq4=;
        fh=TWQEC1oEaS260EcG6YawJMxGX7J7mAPZRFA7rxYqIPg=;
        b=ZHKJzJ+27u7z3mGIdS5kh/k13lmRsL5K+8txbZ0hycp16UppTw1n4lNpzIMs/zjfvh
         Ei+RFc/9B7B1bZqhFnYGhUj+lKMh+1NJPR5lPFFvahz5NzRlq5L8raT4a5l67D5se4Rt
         +HhazCxyxgV4uAuMFyH9XIFW95UfJkoTuUBMAJAffkao4Et574mXn7PeUSGOs0jxr9hT
         5NuiwJJBO5+E1sEvUxpuqE0VVA8sHqB7MHqsy0fyxmR/zU7nZ0BblypLF8Yv7+RpQcV7
         tmX1YTvPhP6yEDVlLQHmciNXVAs6/xvzVjVGQ+Ldryri2HdjXcwapqMaBI9BKGftIG7t
         NC4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782661542; x=1783266342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAv9lBpwJ9ygLTg/j3vYZQS+xwu0/dkisJeUZL+Xgq4=;
        b=cLUg5UvqOdhM8ZAsIaUAbbmgRfvn42ePhn5g3dMuZ4oXsMWkz2q8Gvbn8P073wKnPO
         qMuFrw/meiy+iewb4fGP8wwlCki4pkK+VskBRY9qW+9d8gP08bf2VyeWBm7mjHy1rxo/
         XkiRe7B1z5znr+narhmZZWl7x2efUrPxsWCetzdCcTpTpNFj8AhkkIG8TfDseKwysKct
         U+ee5DTWNqWgGio6i6EVW4NvuQRIJ6LzP2MmltcG6kcTL42xGuGMBQE4q1ikLTO2UPcI
         EAyYs+5hDJajXSZrlZTVHHv1pJvw4q+7ovLRu15LdfuRbomP0PXRVmBuBWk+dJCt0pYo
         Nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661542; x=1783266342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAv9lBpwJ9ygLTg/j3vYZQS+xwu0/dkisJeUZL+Xgq4=;
        b=mg5hz+JvQWN6XX+zsvFU+FmvThR2F7nc8msZwntaihfon/rLqcQtOkvEo+yje4Qq53
         RRs39iDJ1EX6Gec6MxeYUOdOdcjZnl234wTgaBCMZhQGbuwFWd23AjCCAAVesccIxCBy
         3I04xtqDo7RLdX2Lc/1YGVvfbZYnD9y+8+TTgVU1twzrD1tXMgd0l8tYiQU/IKy72Hkn
         XzQ9tr1mC6KSwB9F0FetGapnhiHxYJSlnRrIborr+aj53YQ6puZ08Oo6YEtV0lAjKn47
         wZNIElfySQNxrweuiuINacEAbBht0DkGZSa1avxpRU9k8lRgZbMYoZp6MvAOMRhs5hML
         aKbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp//CSazB7lAZTscSCo0CIoOABOs7yCfFz/UDyBSk9BbWG3ZSXp7/8mZjBNY6cbUegy1fb0mI3BdOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOP/oH9+EXCFRPIz//bCRcvqj1NrXFhKa0INUWcKhknsGKI4j
	8R2SaeQ2/L5KA/x84A/BIGyCqqdq94HG7TmRPFL0IiXFI/u+ld+25zd707FtK2hXCk1e7ncfb6c
	ToLxANhMs8moKnRhdQwx3X19DKLvZWq4wt3qmK/RNKw==
X-Gm-Gg: AfdE7cmgtWCVa3vKqKKwovp8IxBInG2p6RKlZCM9xgSE/hdwRnGGqfHSG/vManXWUnk
	JOi+tYeOzlzSEwEHpB1b7VE5FDdd3LIcFCW65pzQAK1K761eVx0A1pBnkF5ZMFn7XhHqma7Dxi4
	ZqgyTwXI/aDyozupNSyTXo3xl/JinV1G1/nB5enFkqLKJkThlO7HKr6iHwkjAs8J+I/Gi8ZYCBy
	3nycm/UgeCCnujF/MZNrUypc+kzTgfsdF1hDyaoEVAJ5soFBrOswpomTFG5Q6I8IBfem0c=
X-Received: by 2002:a05:6512:420b:b0:5ae:b7d1:1627 with SMTP id
 2adb3069b0e04-5aeb7d116bemr194278e87.35.1782661541572; Sun, 28 Jun 2026
 08:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com> <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
In-Reply-To: <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Sun, 28 Jun 2026 11:45:29 -0400
X-Gm-Features: AVVi8CdnfscTBrE6mgVXhCFi71iOVNGWSd9eLKz04ut2brkiv_wEmc-9eF7BrNo
Message-ID: <CAE+C+DYnidq7ZFoyxeL54YCT=JF5-Q-NkGFTgoAaW9EztwwaGQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Alejandro Lucero <alucerop@amd.com>, 
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:01=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> > The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> > with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> > userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> > offset near U32_MAX can wrap the addition to a small value and pass the
> > bounds check.
> >
> > The wrapped request then uses the original large offset as the source
> > address for memcpy(), reading far outside the mock CEL array.
> >
> > Validate the offset first and compare the length against the remaining
> > CEL size so the check cannot wrap.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
>
> Hi Samuel,
>
> I'd suggest keeping the commit log focused on the broken property and
> how the fix restores it, rather than tracing the individual arithmetic
> operations and later accesses, which are already evident from the code.
>
> The GET_LOG handler is intended to reject requests that describe a CEL
> range extending beyond the available data. The current validation can
> incorrectly accept some malformed requests because of arithmetic
> wraparound, and the fix restores that property by validating the
> requested range in a way that cannot overflow.
>
> The discussion of the subsequent memcpy() access leaves me wondering
> what the observable effect actually is. Does this return bogus CEL
> data, trigger KASAN, crash the test module, or something else? If there
> is a demonstrated failure, please describe it. Otherwise, I think the
> property being restored is the more important aspect to capture in the
> commit log.

A longer explanation appears below, but the bug can cause the kernel
to panic with an out-of-bounds copy. So highlight that fact in the
commit message?

---

The bug was validated with a PoC that deliberately invalidates the CXL
mailbox GET_LOG command to the mock CXL memory device.

The vulnerable code checked the requested log slice like this:

  if (offset + length > sizeof(mock_cel))
  return -EINVAL;

Both offset and length are 32-bit fields supplied by userspace. The PoC set=
s:

  in.offset =3D UINT32_MAX;
  in.length =3D 1;

So the vulnerable expression wraps:

  UINT32_MAX + 1 =3D=3D 0

That makes the range check pass, because 0 > sizeof(mock_cel) is false.

After that, the mock GET_LOG handler still uses the original huge offset:

  memcpy(cmd->payload_out, data + offset, length);

So it tries to copy 1 byte from far past the mock CEL buffer. In QEMU
pre-fix, that caused a kernel page fault in memcpy_orig, through
cxl_mock_mbox_send, and then a panic because the test kernel used
oops=3Dpanic.
