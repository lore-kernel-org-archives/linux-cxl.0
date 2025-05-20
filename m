Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E727AC48
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750617; cv=none; b=szgWT2IqwfGJkYszVZ3YoH8w/lQIb3II+QDrAMDqbCTRSWWMbfi4dsQ/TEScmVVPlFS4pUn8gWRIuNIJKt/ZtorjJGMrYJyfpZHOjG24suCw3g0Pvwo2TVPH0IreK9XKwoHLOVfNPzxuZJrmds/3xcOD33HpSSmFsyiEAb7sM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750617; c=relaxed/simple;
	bh=fcMtT0bHx3wnRKhUmM/Xz9zSpIbq14NKHES2iCRxrlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o9Ra2Lh0/F9lhX/IWX2cYl91rHQHb8FEb+w3UBeQpz0DgL6l5EPxBtXx2Mfdc9kcSRuz+2BQXGqiiwmPo3qK1Xjjl+IAg9HFsbcAmBrHbLwIgLHDvPCXB8kXyYMwiScW/IyJ/h6UaCYh7NpfGsVX6p3tBmF6JvbgOBq08Rza/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeBkwNWX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeBkwNWX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441ab63a415so62829725e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747750613; x=1748355413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CInEGsOLz25mjMs6YRA78p9qw90h7ZdMHZE0ctttrwU=;
        b=XeBkwNWXTgoZY7g01ax+b5q/etCBE86iIHXlm9HCWhshEa/Xicm3ZsRR0YxkaTncLD
         EMWt3vtGP9BMiCKCr8mw/qy7R0uWjuiZAB9VqLM60laa2L0oSlmZh3iCze6fN/+u4ZwS
         Clmpn+eRShZYy1Hqsy7Qg0kuM6V6ZJrK3Gdss16toQ7s58huWDDj4AfIlSgMHYiI84/0
         JN0AYdJqUE2bbsbjjeVvJBi8zqseVGs1HojDh+tr3FATqHi5Kp51aZrnRIO/7fO9XYTC
         qW5w7xTofAIRAGjPxB5oCeedyyHQKLYzl46rMvCgMsu//DKCZIrT1d7S2Z0PxKgckJsz
         y6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750613; x=1748355413;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CInEGsOLz25mjMs6YRA78p9qw90h7ZdMHZE0ctttrwU=;
        b=mEwm5odB+9TRsA9rFFApAQZbC/JVp7e8utm4DXHOte2T1tWPKNkztAuPx1x1k48CI0
         sRZlWOXAFOh6Du3+c1XlC403VuKrxRdRXVKItqaEyWuM50o+nzn2xJ8SiWdEyAmcTXS/
         MEAHDwUS3M3F9tRqVPiEf31DWMjj/OJ+DnWbc9vYysy79g/Qhqe/544QSe7B64ZpqtSR
         wZ+x/UH90g7r71YVORmdedMil53rRDTtMDcnH/JHHtTIFDQl0qtIaaj32uy9nhYDn+3y
         TfUmM/E+i07fPn2HVR6V5kUWahJMkTRBz0gw6xUyEWJ/0NObXb+1f10+dDWdv/O1QlBd
         4rew==
X-Forwarded-Encrypted: i=1; AJvYcCWmsXVkqaD8vKf0fDpwDqIHwOlIjvuBbtwWjpLd4XoTfjZIIk04zHE2GrfuR6WmM3bKWq61z3ZfuNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2b0EflkC7LOaZjh5TISA12wJXkdZzDmaoIKNJRUJ1U/qU1zs
	mC8lpWXAaYddzwppSTIWyIwH3J8rDlM3W/AoOfr66m1W6lX1O/wmEj2y15Ah7wT3Ym0=
X-Gm-Gg: ASbGncvQP+pZfl1wroTREb1EWo3vkkwLyrbK9Mm+0Il8sQY+b6H1eDoy9QB2RW8u1Gt
	evAGwoIrssFzFRc8V8nD4K99n0MS8ZTqbxBIs6/t7PjCcPwLksTTbFIO5j77xagKtKWCGYiAXo3
	ENUd59+t5pY0zEiwxI48XblKjAQkKwnepN8kBBeCf6voYnV+h6fTyGnn9bGp0TFwFbjL9LcK1aa
	Df2Ut8IgZE8oUn+JrWvGmaqZvEHH60kxxZojfMuodSI9Jci0fWGxHHLeSsi9Rj8/UKMhqwFCrnS
	vJhMLAC+8ZP3Oqog7j8o91AE0kkCOHOBbA+5B6mTrQ/TuDOnYT8h
X-Google-Smtp-Source: AGHT+IHyqae4al0WhGqWVoe23MBDbSjMoqgbacwPgIiLS45edaSa3sgI2O1OQM1X/goV9Fj18sto1A==
X-Received: by 2002:a05:6000:3111:b0:3a3:7d7f:47bf with SMTP id ffacd0b85a97d-3a37d7f4827mr492589f8f.4.1747750613368;
        Tue, 20 May 2025 07:16:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5abaesm16638636f8f.39.2025.05.20.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:16:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id AC9E35F7A5;
	Tue, 20 May 2025 15:16:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <fan.ni@samsung.com>,  <linux-cxl@vger.kernel.org>,
  <qemu-devel@nongnu.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  <linuxarm@huawei.com>,  Niyas Sait
 <niyas.sait@huawei.com>
Subject: Re: [RFC PATCH QEMU 2/3] plugins: Add cache miss reporting over a
 socket.
In-Reply-To: <20250124172905.84099-3-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Fri, 24 Jan 2025 17:29:04 +0000")
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
	<20250124172905.84099-3-Jonathan.Cameron@huawei.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 15:16:51 +0100
Message-ID: <87zff79xkc.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> This allows an external program to act as a hotness tracker.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  contrib/plugins/cache.c | 75 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 7baff86860..5af1e6559c 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -7,10 +7,17 @@
>=20=20
>  #include <inttypes.h>
>  #include <stdio.h>
> +#include <unistd.h>
>  #include <glib.h>
> +#include <sys/socket.h>
> +#include <arpa/inet.h>
>=20=20
>  #include <qemu-plugin.h>
>=20=20
> +static int client_socket =3D -1;
> +static uint64_t missfilterbase;
> +static uint64_t missfiltersize;
> +
>  #define STRTOLL(x) g_ascii_strtoll(x, NULL, 10)
>=20=20
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> @@ -104,6 +111,7 @@ static Cache **l2_ucaches;
>  static GMutex *l1_dcache_locks;
>  static GMutex *l1_icache_locks;
>  static GMutex *l2_ucache_locks;
> +static GMutex *socket_lock;
>=20=20
>  static uint64_t l1_dmem_accesses;
>  static uint64_t l1_imem_accesses;
> @@ -385,6 +393,21 @@ static bool access_cache(Cache *cache, uint64_t addr)
>      return false;
>  }
>=20=20
> +static void miss(uint64_t paddr)
> +{
> +    if (client_socket < 0) {
> +        return;
> +    }
> +
> +    if (paddr < missfilterbase || paddr >=3D missfilterbase + missfilter=
size) {
> +        return;
> +    }
> +
> +    g_mutex_lock(socket_lock);
> +    send(client_socket, &paddr, sizeof(paddr), 0);
> +    g_mutex_unlock(socket_lock);
> +}
> +
>  static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo=
_t info,
>                              uint64_t vaddr, void *userdata)
>  {
> @@ -395,9 +418,6 @@ static void vcpu_mem_access(unsigned int vcpu_index, =
qemu_plugin_meminfo_t info,
>      bool hit_in_l1;
>=20=20
>      hwaddr =3D qemu_plugin_get_hwaddr(info, vaddr);
> -    if (hwaddr && qemu_plugin_hwaddr_is_io(hwaddr)) {
> -        return;
> -    }
>=20=20
>      effective_addr =3D hwaddr ? qemu_plugin_hwaddr_phys_addr(hwaddr) : v=
addr;
>      cache_idx =3D vcpu_index % cores;
> @@ -412,7 +432,11 @@ static void vcpu_mem_access(unsigned int vcpu_index,=
 qemu_plugin_meminfo_t info,
>      l1_dcaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l1_dcache_locks[cache_idx]);
>=20=20
> -    if (hit_in_l1 || !use_l2) {
> +    if (hit_in_l1) {
> +        return;
> +    }
> +    if (!use_l2) {
> +        miss(effective_addr);
>          /* No need to access L2 */
>          return;
>      }
> @@ -422,6 +446,7 @@ static void vcpu_mem_access(unsigned int vcpu_index, =
qemu_plugin_meminfo_t info,
>          insn =3D userdata;
>          __atomic_fetch_add(&insn->l2_misses, 1, __ATOMIC_SEQ_CST);
>          l2_ucaches[cache_idx]->misses++;
> +        miss(effective_addr);
>      }
>      l2_ucaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l2_ucache_locks[cache_idx]);
> @@ -447,8 +472,12 @@ static void vcpu_insn_exec(unsigned int vcpu_index, =
void *userdata)
>      l1_icaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l1_icache_locks[cache_idx]);
>=20=20
> -    if (hit_in_l1 || !use_l2) {
> -        /* No need to access L2 */
> +    if (hit_in_l1) {
> +        return;
> +    }
> +
> +    if (!use_l2) {
> +        miss(insn_addr);
>          return;
>      }
>=20=20
> @@ -739,14 +768,16 @@ QEMU_PLUGIN_EXPORT
>  int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>                          int argc, char **argv)
>  {
> -    int i;
> +    int i, port;
>      int l1_iassoc, l1_iblksize, l1_icachesize;
>      int l1_dassoc, l1_dblksize, l1_dcachesize;
>      int l2_assoc, l2_blksize, l2_cachesize;
> +    struct sockaddr_in server_addr;
>=20=20
>      limit =3D 32;
>      sys =3D info->system_emulation;
>=20=20
> +    port =3D -1;
>      l1_dassoc =3D 8;
>      l1_dblksize =3D 64;
>      l1_dcachesize =3D l1_dblksize * l1_dassoc * 32;
> @@ -808,11 +839,39 @@ int qemu_plugin_install(qemu_plugin_id_t id, const =
qemu_info_t *info,
>                  fprintf(stderr, "invalid eviction policy: %s\n", opt);
>                  return -1;
>              }
> +        } else if (g_strcmp0(tokens[0], "port") =3D=3D 0) {
> +            port =3D STRTOLL(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "missfilterbase") =3D=3D 0) {
> +            missfilterbase =3D STRTOLL(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "missfiltersize") =3D=3D 0) {
> +            missfiltersize =3D STRTOLL(tokens[1]);
>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;
>          }
>      }
> +    if (port >=3D -1) {
> +        uint64_t paddr =3D 42; /* hello, I'm a provider */
> +        client_socket =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +        if (client_socket < 0) {
> +            printf("failed to create a socket\n");
> +            return -1;
> +        }
> +        printf("Cache miss reported on on %lx size %lx\n",
> +               missfilterbase, missfiltersize);
> +        memset((char *)&server_addr, 0, sizeof(server_addr));
> +        server_addr.sin_family =3D AF_INET;
> +        server_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +        server_addr.sin_port =3D htons(port);
> +
> +        if (connect(client_socket, (struct sockaddr *)&server_addr,
> +                    sizeof(server_addr)) < 0) {
> +            close(client_socket);
> +            return -1;
> +        }
> +        /* Let it know we are a data provider */
> +        send(client_socket, &paddr, sizeof(paddr), 0);
> +    }

No particular objections to the patch as is. I do wonder if it would be
worth exposing a chardev pipe to plugins so we could take advantage of
QEMU's flexible redirection handling.

But not a blocker for this.

>=20=20
>      policy_init();
>=20=20
> @@ -840,6 +899,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qe=
mu_info_t *info,
>          return -1;
>      }
>=20=20
> +    socket_lock =3D g_new0(GMutex, 1);
> +
>      l1_dcache_locks =3D g_new0(GMutex, cores);
>      l1_icache_locks =3D g_new0(GMutex, cores);
>      l2_ucache_locks =3D use_l2 ? g_new0(GMutex, cores) : NULL;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
