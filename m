Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D991B81B
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505553; cv=none; b=eQzSEzeNZUh2PGR9SucTDOjE4yeRAT3J8Lc2fkP0JwAzlk3I+C5RwvpUE2s4jzgyuxYEzr3WiuBxKEDwma6M7PYVA0bfy+Yxc0iOl8HJC8tcPdClaMLTvOCEj/8HUbSGtURlaMHxA/sHg4pUYcE8y0Ge+7F+G2vE6Z1ns7fsSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505553; c=relaxed/simple;
	bh=dGEOnosIZebwAk0uJhqjdDOhe9OemDY8xHqEY/u1b6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6kHXNcgGcgFRjzMA97Sjgh7W9k5Pc7cswnVtF1CnmWUYnz0NbqfshkveI3m99WQV+95aIWCzjCheYN8URO3mdI3EreAIUzEvdAffiZQy3kFtt2iBr4eBZOKVVsQrZaEXgI7loOY8RjR2rSzrs2hW7kF7hlHhIP0y92tm1d4i7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhLKGd46; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhLKGd46"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414025406d7so2343235e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710505550; x=1711110350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3BN1N6N0KvJh7B/oVj292iIgD+UIsCS4UlVg0JoZ8Y=;
        b=qhLKGd46evUU+TXJQdPookZk4sfX/IWW1z8BIpYUIyzAJDzDXOIEP3ltls4o7mb2Pd
         C79lPlr7Go8Acum+7geDjnih/zZaAB7aUiUxoQ9dRx1bcM4KXL8fAxWUpA8mmtD6iSZy
         dOfdJWx/rWXpR2WckxfI6b7/WbO1aSCdLL/OF8SCTwNz1zFB4jMfebzfEmtzEFGWzWzg
         ryf4CqED+bBjMOf4DFdksI7IRU0SoSpCcQAAVGYFQAcKBO1vHU7zUtyO+sBTt8tuovqu
         UFjOZKSUWFBFZZu+dVQXQGuAI/aUBFIK9VpljvOQq8CuY5OmFKfhUDJrOY6Kb/0r9Jsa
         5oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505550; x=1711110350;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3BN1N6N0KvJh7B/oVj292iIgD+UIsCS4UlVg0JoZ8Y=;
        b=ZBfy5q+3bkPz+03tJXrFZJZDGuZlVVJPCHGLWJbY+vPdjcIroumV4db6P2otfxbDng
         LbWl6sNb83AlDSIiBMWp5zOIpkVfPdqtyBP8g3KgqO+hzMnNPnZUFp+AhJG1scSdDAQW
         hCHG5pTC9rmVqbpivlqwZOTUE0X3PAUYqT7sEc+aBQQnJ8lNRpAkj/a6BUjTMUj+EeHW
         DwgiqCqcIK3rA0xOJ7dr+RkysAstScvt4BU7d7OAWBrJiZY6duSRIYMCJq88+6qMc0dg
         4ay0KRwyxcVpmVtUjKOGJqOZCb2HOFFiaStAvVbR8I04y2GOD2jjdeduVE6tdQomxebf
         jSjA==
X-Forwarded-Encrypted: i=1; AJvYcCXIyehg0E9Gl3fj8DWNNSl4YjbIf5hO6Kb3K81Fsx9y4UF/ep0E6J9hrRaf4fZPUXMQnZUNeq1Rlh+Xa+xaAM1404F8xBv7PKxg
X-Gm-Message-State: AOJu0YxNe/nxJ3yuyparv6WWfzNzXSa85GVZFXxMtj6avM4jRcm1hR4e
	1vm7fqK5CDaTNhbQ0DSZ4I09gCcSGVcIeZTIDoTeJ+Isc0riob5m2J4PR057RAjZ8EalNJa93nM
	d
X-Google-Smtp-Source: AGHT+IEuGiQtQVPYA3SPs6/K+XPBBXFzISBgl15s/4g/tKYUI3nWkYbkr3QxzNF7I/re+ANwd40hTQ==
X-Received: by 2002:a05:600c:4f91:b0:413:2852:2835 with SMTP id n17-20020a05600c4f9100b0041328522835mr3476838wmq.17.1710505550239;
        Fri, 15 Mar 2024 05:25:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id hg25-20020a05600c539900b00413f08c4d2asm5556574wmb.37.2024.03.15.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:25:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2FB025F8A0;
	Fri, 15 Mar 2024 12:25:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?J=C3=B8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
  "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
  "richard.henderson@linaro.org" <richard.henderson@linaro.org>,  Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Subject: Re: Another CXL/MMIO tcg tlb corner case
In-Reply-To: <33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?J=C3=B8rgen?= Hansen"'s
	message of "Fri, 15 Mar 2024 09:36:16 +0000")
References: <33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Fri, 15 Mar 2024 12:25:49 +0000
Message-ID: <87v85n3cmq.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B8rgen Hansen <Jorgen.Hansen@wdc.com> writes:

> Hi,
>
> While doing some testing using numactl-based interleaving of application =
memory
> across regular memory and CXL-based memory using QEMU with tcg, I ran int=
o an
> issue similar to what we saw a while back - link to old issue:
> https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=3DEpz3_+CheAT8Crsk9mOu89=
4wbNW_FywamkZiw@mail.gmail.com/#t.
>
> When running:
>
> numactl --interleave 0,1 ./cachebench =E2=80=A6
>
> I hit the following:
>
> numactl --interleave 0,1 ./cachebench --json_test_config ../test_configs/=
hit_ratio/graph_cache_follower_assocs/config.json
> qemu: fatal: cpu_io_recompile: could not find TB for pc=3D0x7fffc3926dd4

Ok so this will be because we (by design) don't cache TB's for MMIO
regions. But as you say:
>
> Looking at the tb being executed, it looks like it is a single instructio=
n tb,
> so with my _very_ limited understanding of tcg, it shouldn=E2=80=99t be n=
ecessary to
> do the IO recompile:
>
> (gdb) up 13
>
> #13 0x0000555555ca13ac in cpu_loop_exec_tb (tb_exit=3D0x7ffff49ff6d8, las=
t_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffc3926cc0 <code=
_gen_buffer+464678035>, cpu=3D0x5555578c19c0) at ../accel/tcg/cpu-exec.c:904
> 904         tb =3D cpu_tb_exec(cpu, tb, tb_exit);
> (gdb) print *tb
> $1 =3D {pc =3D 0, cs_base =3D 0, flags =3D 415285939, cflags =3D 42783211=
52, size =3D 7, icount =3D 1, tc =3D {ptr =3D 0x7fffc3926d80 <code_gen_buff=
er+464678227>, size =3D 176}, page_next =3D {0, 0}, page_addr =3D {18446744=
073709551615,
>     18446744073709551615}, jmp_lock =3D {value =3D 0}, jmp_reset_offset =
=3D
> {65535, 65535}, jmp_insn_offset =3D {65535, 65535}, jmp_target_addr =3D
> {0, 0}, jmp_list_head =3D 140736474540928, jmp_list_next =3D {0, 0},
> jmp_dest =3D {0, 0}}

with an icount of 1 we by definition can do io. This is done in the
translator_loop:

        /*
         * Disassemble one instruction.  The translate_insn hook should
         * update db->pc_next and db->is_jmp to indicate what should be
         * done next -- either exiting this loop or locate the start of
         * the next instruction.
         */
        if (db->num_insns =3D=3D db->max_insns) {
            /* Accept I/O on the last instruction.  */
            set_can_do_io(db, true);
        }

and we see later on:

    tb->icount =3D db->num_insns;

So I guess we must have gone into the translator loop expecting to
translate more? (side note having int8_t type for the saved bool value
seems weird).

Could you confirm by doing something like:

  if (tb->icount =3D=3D 1 &&  db->max_insns > 1) {
     fprintf(stderr, "ended up doing one insn (%d, %d)", db->max_insns, db-=
>saved_can_do_io);
  }

after we set tb->icount?

> If the application is run entirely out of MMIO memory, things work fine (=
the
> previous patches related to this is in Jonathans branch), so one thought =
is that
> it is related to having the code on a mix of regular and CXL memory. Sinc=
e we
> previously had issues with code crossing page boundaries where only the s=
econd
> page is MMIO, I tried out the following change to the fix introduced for =
that
> issue thinking that reverting to the slow path in the middle of the trans=
lation
> might not correctly update can_do_io:
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 38c34009a5..db6ea360e0 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -258,6 +258,7 @@ static void *translator_access(CPUArchState *env, Dis=
asContextBase *db,
>              if (unlikely(new_page1 =3D=3D -1)) {
>                  tb_unlock_pages(tb);
>                  tb_set_page_addr0(tb, -1);
> +                set_can_do_io(db, true);
>                  return NULL;
>              }
>
> With that change, things work fine. Not saying that this is a valid fix f=
or the
> issue, but just trying to provide as much information as possible :)

I can see why this works, my worry is if we address all the early exit
cases here.

>
> Thanks,
> Jorgen

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
