Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41A212564
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186975; cv=none; b=rIdvAWvZarGcGvL4OJlPU1S0CTVF9YGV0xmzaw16xX+M+kd9oNxdEu9xVPcarEamHulPqTaTGwKiLjcOdiPGjgntADrJOB9zzMI63Z+TZ9MFvnNRgkwtnTmBML/jd7/qWk7vkIAb5KLVWS1yATCZoSr+AeNFbnspNH8bP1ERG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186975; c=relaxed/simple;
	bh=kpXA6yFcgEj/dZUYvtOkGjq4OnKrIjZeikESSLTpnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bm/N7PLkX/8WIe8Jb9EQRycpgNlApT1b3SIQMeOwpRJhim2i8lyo674eLBzH867IJOz3z4Uz6BjlpvABJq0490G5kdwBV2ebyd+gO3ccDImFomSyl2K8P9JuFNqVLAoxNTFknFt99gc24f14bHl6EcDSRVhCxizbwAHJrI4zUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uOGvDTP5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uOGvDTP5"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9178510f3bdso4346346d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186972; x=1792791772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2FeU/KA/HdZ7zmpfqoNfHf522vbSJvjixYnmAFtz/0=;
        b=uOGvDTP5dMaEoor3w3mNenmPGErss8nEf3Gtlvm6C473Dy9I/rulT31cxW1iKKKnD/
         zx1sz3Ivf19pu5GjxE4UDEP772Q7sW0iJF+hqkuCNwgeBTIX2yq61CUywyiU0gpgbgid
         LSa5RUyxEyxbR0d4/Eh+9OEYJp76WmFVf6f4r6UFFORMC9fq1o9UM6Mway5bDndwM+Dm
         VTgd7MI9+e67lK8Ja6nM2GdlBfTF++cMNwwVv1IfEwEEnTn24pDAzH6xPrBCu2GXoXVU
         0v3eTpDUeGNi5FATjuswnwJLt7nfw+FT1458BslZVl+TwwEqW9Et2tbeahFgFlSLlvR8
         a98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186972; x=1792791772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2FeU/KA/HdZ7zmpfqoNfHf522vbSJvjixYnmAFtz/0=;
        b=c63liXgq6kG32kMFM5IvXGg+rrsNOkU9yOOxGRcyv1lTmwCXez4w1TWSuOq8Q9uCMK
         q/yTMoEmmbrrwuwz3esD2viNGym6bQBX0bMPWhBrdMnJLrYBoJPh5iW1AE6awuo3ikkC
         5oCBwJGk4+gxhsa4c9c8QfzATS7Be2zSTeTesY6EzetU6bh8azUrrg4rApuem2YnFuLQ
         xWKtBvQfIgW6heIMRvIUlgQWAmf90zkA48L+IbWX5nWd6+zpB0glUSsoZvZ2LEYEXqWX
         EktypeMXn/pLMRsWHZLHejSAmi/S/79AV/sYYVB0MffFOq14XvtGtCy/3BnD39DJlYiV
         HeOw==
X-Forwarded-Encrypted: i=1; AKwUvBwC11WsId4eABhTECEfF54P5lccEqoMT23yc91JHkK0B8rvVws9UsA/afdF1X0kgBO47cueX3Gc/rk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeG+0TMmHiQKsFxwbfRShI87JhUPU+54D0cEhw7+vgj1nvQXQf
	iXkMgdWiC+gL/njBfyy2RItcxHcgWS6cwNl2GzFaWek/ncAfSFEio60jx+ENl33i7rSFb6T+DoK
	uFG3FVfY=
X-Gm-Gg: AYBFou08O2Yr0g9YDkzTCiFvoorI1LDbU2XjTHQskjsvn/5NwaolM+ass11IF9iaNuz
	p92SHMZP8icd7WxJXsnoSk85qG1FKYngnyIak1eJpAH9h7oe4HFAL+eogGpFCkTQg1nLLbcavu6
	GGoi5MoE+n9n0AQ5kfFmt7WqU6DaoRnuj5Og13UlxZIxtpFdzvZDj1Gk3PyfeaSmF56/kzwx1Ez
	yAOXKw8YvY8lcddM1xN0Etv2590AWuYfxgE6pjaN3CDOnHocFGm6/Bi6fWJD6ZOMLPcSvyQTGQa
	Sf5zAWnyVcsm1Om2kstUweiE/q+UA2u+2wNzeEAgEYq7S4+Yiz39WdyJb5xgCMs6UVskE5bVUeU
	Zc8/+rrAi+R0BR2ZMQAX0NOPJMVrTswS95MV+3wKhHV2GuOoNWidzV4Sd7iRwMxsZCEAsm18Hcc
	GJxF5mrkLyPB57Ir6d5m6DGw1nYOP+kebEGmqPP6FcXXV3lySeCzbQyRmFaklAj2ERt+CluAXoY
	5OhN/RdLch5EPhBrmCnGjLxWaqqoLOBDodkSU2otp0BWCVpIwpC+P3viyH5Kw3FyFxUdH8=
X-Received: by 2002:a05:620a:2609:b0:93e:7dfa:2f3f with SMTP id af79cd13be357-93f29d9614cmr208269885a.62.1792186972297;
        Fri, 16 Oct 2026 14:42:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:42:51 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [PATCH 0/6] daxctl: use dax kmem atomic whole-device hotplug
Date: Fri, 16 Oct 2026 17:42:42 -0400
Message-ID: <20261016214248.443247-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernels with the dax_kmem daxX.Y/state attribute [1] can unplug or
plug-and-online a whole device atomically. Use it in daxctl
online-memory and offline-memory so other agents (udev, auto-online)
can't race daxctl block by block, notably the offline-then-unbind race
on teardown.

Kernels without the attribute keep the per-block path.

Behavior change: offline-memory now always unplugs the device (state
'unplugged'), removing its memory blocks, even if they were all
offline already. Previously that was a no-op.

'daxctl list' (and 'ndctl/cxl list -X') gains 'hotplug_state',
reporting daxX.Y/state. The kernel only updates that when written, so
it goes stale if blocks are toggled individually.

If there is a mismatch between 'dax/state' and the blocks, then
'hotplug_state' reports 'inconsistent' (online state / zones disagree).
That is intentional: it flags agents fighting over the device.
It only appears when the attribute exists.

Compatibility notes:
- Where the unplug fails (e.g. no memory hotremove support),
  online-memory falls back to the per-block path and offline-memory
  of an already offline device remains a no-op.
- Older daxctl/ndctl/cxl binaries don't expect a device with no memory
  blocks.  Basically multiple daxctl versions on the same box can cause
  older versions to fail when in the unplugged state.  Not a huge issue.
- If re-adding fails after an unplug (e.g. region can't be reserved)
  the device is left unplugged.
- For multi-range devices the kernel succeeds if any range is added.
  daxctl can't tell that a range is missing.

[1] https://lore.kernel.org/all/20260712154505.3564379-1-gourry@gourry.net/

Gregory Price (6):
  libdaxctl: add dax kmem atomic hotplug state accessors
  daxctl: online whole-device memory atomically when available
  daxctl: offline whole-device memory via atomic unplug when available
  daxctl: report whole-device hotplug state in 'daxctl list'
  Documentation: describe atomic whole-device hotplug in daxctl man
    pages
  test/daxctl-devices.sh: cycle offline/online to cover unplug and
    replug

 Documentation/daxctl/daxctl-list.txt          |   5 +
 .../daxctl/daxctl-offline-memory.txt          |   5 +
 Documentation/daxctl/daxctl-online-memory.txt |   5 +
 .../daxctl/daxctl-reconfigure-device.txt      |   5 +-
 daxctl/device.c                               | 156 +++++++++++++++++-
 daxctl/json.c                                 |  53 +++++-
 daxctl/lib/libdaxctl-private.h                |   9 +
 daxctl/lib/libdaxctl.c                        |  71 +++++++-
 daxctl/lib/libdaxctl.sym                      |   6 +
 daxctl/libdaxctl.h                            |  18 ++
 test/daxctl-devices.sh                        |  53 ++++++
 11 files changed, 379 insertions(+), 7 deletions(-)

-- 
2.53.0-Meta

