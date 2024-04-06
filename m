Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850C535AB
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442774; cv=none; b=muVqMD3wJEU1F7FaCZytBnabLei1ENcY75JZrgM4LUNPQo7j0iKZp+jym7Ehnab3AOyFysHaj8DzM1+X9SOO6lLgswHFYAFPr2+CLwZx5s45Nt18tqRDvhLO4mVzF96vi1MVf9h7AXyF0hRnav8vyP5EbnaqJYcYxgLcNl4WJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442774; c=relaxed/simple;
	bh=hFaMT0yb/OOU7h1z2or7U9zEVXvGWsaYp+bjXxrWhaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cs/rGYCamI8m4GtKkUPX0kT6V0M9ussj2u8b3om+NrnYmFk/9iV4N+ZGyx1gUEGc2I2oM0jgJvILTk0dcKH11Mfv1BTjWiRLBzcSQvFMATIrGuBQYKk8cGmHIMpIB3yVHYksEfmjg71p6B7tV2n5ZTPhFBTe+wjaTwAle0GX0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hv25M35u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv25M35u"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so1891189a91.1
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442772; x=1713047572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36ZaUeVzVuWegwno9pEm8v7DMzHgHRm99UuSw/pVQC0=;
        b=hv25M35uHf5GkTLMXnC7ld8j9RVIx7adKljvc+yGc2GhjlRRni04RuyZtJIw4UeuA4
         XJj0M/UTdxCg7z0w8ZO8OwFkqJpsBi0x4HreFmK1OtHTOSU9GBLQ1PCUB9qwcfhsf0Ms
         SXhUCh9/aca0uSs9bggiNuvfQV7sSNMwVZ62+OGrrBDN2JvLpimlIe9Y7P+BwUGYpmLO
         n0GrEq4Ie/08ZFd7qS5cNEShZD7SQNgAy0lHnuJu4efuxg61tK55vBuAeU1mW1nSJLXL
         koVrd12XmPSaCp/EsOPYS6xX7BPiRB7HnJB6jRwTOUcygh821sp2NM2XXk9n3IAK5vJ1
         mKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442772; x=1713047572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36ZaUeVzVuWegwno9pEm8v7DMzHgHRm99UuSw/pVQC0=;
        b=oJ/11Bw8caJQZe6kwe2paC2aUuzls1vny8viA/FQ7QPw+88WxkQIY3VhP2xGrVjKuC
         B5h7vM3cqpo/mbm7WJg4O8a6QkF4XSzLHvZbEqOaHBw7WZ/s4SkRn+AKFXrhsyp797J7
         YaaULdeAIel2NqgS6mjA15t8KQrzZZFnIBZ35kxMn3AiO6nZh3TwyS2kEUdlR1q1Vb8E
         dQ9VRf9jUysT//8n42ShxoyVVg6kv7WLjcxCIZA7q9hQ07cJHJ3skZT5dMNqENHWKLhT
         JqeX54Xn1GJQhVF42BGkhrxrx2FVbud54ASJO6mU6nh4Tjh338Q9Flysl0kM9taTn1BZ
         2uAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcBkfHNU5RaCB0jH3sYYDCCX+PI2ySKC1DhyTEcMs/6u/p0YczJF20twxw8IejpzS5MyrVT5G9o46S9FXtXrge8rubGxNYmDMQ
X-Gm-Message-State: AOJu0Yzj9uzCMHAoZQQLZ2qFxNxlCyJAXufyqjoGH7Oua+iWFqH4OlMy
	pz5U9GYmBU1g+j7OK2A9PPyop87now8tbLQE1q4ZW/0VOI/Zuf5/ra7gGw3Srv8=
X-Google-Smtp-Source: AGHT+IHSLaVBjHa45krFIMqCaQ2KOlRgRmkEJyMSJTwP7R/UFHHN+VgqD0DlRzE5sDPE6Hy6GHWEtw==
X-Received: by 2002:a17:90b:1b04:b0:2a0:4a82:5b05 with SMTP id nu4-20020a17090b1b0400b002a04a825b05mr8585132pjb.19.1712442772255;
        Sat, 06 Apr 2024 15:32:52 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:32:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH for-9.0? 0/9] accel/tcg: Fix can_do_io vs 2nd page mmio
Date: Sat,  6 Apr 2024 12:32:39 -1000
Message-Id: <20240406223248.502699-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug report is
https://lore.kernel.org/qemu-devel/33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com

Jørgen properly identified the problem, though calling set_can_do_io
in the middle of translator_access is incorrect.

It forced me to do something that's been in the back of my mind for
a while and track the insns being emitted so that we can go back and
insert the proper store to can_do_io after code for the final insn
has been emitted.

If we decide to take this for 9.0, most of the target changes could
technically be left for 9.1.  With the exception of i386 and its funky
case of "pretend we never started translating the current insn".
But I think the target changes are minor enough to take them anyway.


r~


Richard Henderson (9):
  tcg: Add TCGContext.emit_before_op
  accel/tcg: Add insn_start to DisasContextBase
  target/arm: Use insn_start from DisasContextBase
  target/hppa: Use insn_start from DisasContextBase
  target/i386: Preserve DisasContextBase.insn_start across rewind
  target/microblaze: Use insn_start from DisasContextBase
  target/riscv: Use insn_start from DisasContextBase
  target/s390x: Use insn_start from DisasContextBase
  accel/tcg: Improve can_do_io management

 include/exec/translator.h      |  4 ++-
 include/tcg/tcg.h              |  6 +++++
 target/arm/tcg/translate.h     | 12 ++++-----
 accel/tcg/translator.c         | 47 ++++++++++++++++++----------------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 target/hppa/translate.c        | 10 ++++----
 target/i386/tcg/translate.c    |  3 +++
 target/microblaze/translate.c  |  8 ++----
 target/riscv/translate.c       | 11 ++++----
 target/s390x/tcg/translate.c   |  4 +--
 tcg/tcg.c                      | 14 ++++++++--
 12 files changed, 70 insertions(+), 53 deletions(-)

-- 
2.34.1

