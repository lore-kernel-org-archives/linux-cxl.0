Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DFB38E5CC
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240892; cv=pass; b=hKJfj9I607nWOyfVdopPjYejHMAdetBg7M56tFiBWHeMfbm77fBp8dsnfahJNGf/JXcZDaDqkQsOfymVDPpfHshoNRy7/MwsiOlPTLE7rlKCdN7MaXeT1oECUw1ovcypCoB/T3V3SOfMj62MFOYoW9FmaYtpI/zPra+FYA4+8Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240892; c=relaxed/simple;
	bh=dScz90nNDOjVirtoaztnEEXydrTbukLSFS4Glyb94Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie665qmb/R/gMK8Pg2vpZYY51/w/DFRnxoJRw2S1KKXxCpmdd+vOhPaWRKnVey3QHXbaPQjLj4u9x/ES6nqwEt8KXodwKwufPnySX06aPpkbacNtqa46PhxWWo7YkjsTUqXvFFMKRz6X9IV5Xwe43vTwlh2pFtV+10ABb42L3/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lycKijnT; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lycKijnT"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-124a1b4dd40so562393c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 13:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770240891; cv=none;
        d=google.com; s=arc-20240605;
        b=Sg+X46z4iKuzhKWEtY3KP/TbiQvWbNITHCmbQa+m1GHNp2mxvxRsehFDnlXqckd273
         6RP8eczf/9E1nWrBtHgQDe+rpyIE+CyCtaAtkhS64OpgCVFKFuylMl1GZvf0IzIsoC1o
         p9Zw2AzKPjxeL40FHZU7evSIwv6h4tYWBxjeLTDLNsF9mx0mW6Z7M1kNDg3wtrg9Xamv
         2ybdRa5Akxi3JO9K8t0Zz52blVsOg08xoFI9pedQWJcBgJZIwYu/XiVS1PwDY8UUGE8L
         tFXVDi7awnF+8P4sO7GmPdO6dfAag9vmab/4kgnTePk8mQrc/sGzrba2Co1x+DwsMNcy
         Au2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
        fh=QxejFzr3LrmHUqwkmGNjtHNOyNW0O1mP9c4iHA084os=;
        b=bp6xzSYOJx0gsGDqnynBQ5gXnXx0Fq4QO002e0CO6CGOdjgl1xMVegcebOw4k8/EKR
         Qtq3k5kdrif9sOylGWPyF4daoXS9eQXavFSycbgQlqe69eUCUGuAaA030wW8Skl8NBRW
         zwp1VHyS0UumMUrRx62YEwnWLz6N5HJpcgt7kTpIfafwFCS7KpcmrM77Z4Fsn4PIcDlB
         NNc/R8wtUEp15aiUyoypVa0MC/oxqBY3KsosxdL8WyI/HWqcqaZ7Xps0ha9iMQDWBYeN
         jgDzULo4nuFKxFWy782swnsKDepCZc8mv/8b6R+/iv7rUrV4VbXvnN+5ag/m01Qdi/rk
         pmDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770240891; x=1770845691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
        b=lycKijnTXk8ZPHEgcJ9LjTyyquuhyxf1aDaSZ1I9/k1k3H1LpDM6STeTqH+VtaOHNA
         nJGD/zuTvSt+Wkc5i9wTLIpHAosc31gtWR2EOkaR6dtuaEHV09wat7k9R9cfnSHz1vjM
         C3KhOOl2ZzZIFPmJ2gadv8vwJvdrhXk9b3avv4v9ob67Stb54tHD1HAnUzofqfmD6WCv
         rYwICyq66WSzkvC9P1N4/FX4Q5bBy92ri8V4Yuz2QKOQRur/cGRlG0M6NW4lbw7sfy6i
         w20tSKhawMIDMWQ6lVcM8y+TEQTInyhS5Z0RhhZiQEVjuP44pZQmLx99g6vUqerWdqpu
         qd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240891; x=1770845691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgF+uj92nP2Cqn99dPdrcIPKrgdgK5YRsSOVi+XsATs=;
        b=Z2a6TYsCzG+nU+1BEPT8Lm/2kRdgXmjSNMVXyQj+iWGH6Sfmpq0U2FrhLCeBTU7Bdx
         PNTYTUdFF7qMiqjzM9kAV5PnU+xRasqpmMHfxXPBRf2wzFrCRkNTgHpGdQDaS0CKxxct
         /3DAsdPQV9pqBayQXxow01ohVYN1sT8dXLhIFdvKw/bCcllg8YHDvW3WfukNT6xWJO19
         BWrynNUtVAwvM6+rOqBo/b2Ib2J0MaV75cF/COloEsgfSMCM0foH97mkZUcmEEBH+CGU
         UK6kkcEatk8hInuLI520v6yHoZ908/MaGmmZnf7w4iYzHPK3+AfVAR2nxmtxF6AdCfXa
         HPWA==
X-Forwarded-Encrypted: i=1; AJvYcCUrU0aRb0oEgDn2elnk5iMIJoqB2yHHizuqCXKJVBIQiVyYAZ5VcyrB4qihtXpIU5KGEDZwpKz6qus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mx29A8K1Np7mgiYea5O1dMaX4DnDZXDEgHEKu6/bFxXZRiYx
	meRM58RjUZlmzuJ0ld8w9QLWrdIL1W6FnBfBY+5QypGRnAhiZhFCnGdkPjRemdi7pyhKZ5yFOrK
	O0ZAJ89T53vVUg7+HHNpcD5vn0y6Fnw==
X-Gm-Gg: AZuq6aI2oa8tLe1fvC2+hP9uJ5uweBppcRJNkrUpFeTb1Z8CE5QiGnhLU/s1focv7b9
	lNVnW17swI9IzUV8XP+vz3+YhOgSWVGwvEgaLMH4BoyxIuVRTug5lMJ+WupFHHesPV9SU/bCGgn
	rMH0z3serjcviDxoQFi+ECPLGb1548TTIh6l49jGwiUEYsi4tKAI4xkuvIAk5qD4K39MQpUPPtt
	r7RT/M8QoNSYsquLiZjwuKU1yDEAkiqnoxN86iOgfhE/LHNBFFtC9buc3C57xhM1M//oKxnqMat
	u76XaQ==
X-Received: by 2002:a05:7022:6182:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-126f47cf682mr2223956c88.40.1770240891041; Wed, 04 Feb 2026
 13:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> <20260119111542.788389-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20260119111542.788389-2-Jonathan.Cameron@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 4 Feb 2026 13:34:39 -0800
X-Gm-Features: AZwV_QhWmPRYqkKRihjkWxw9e2dGMntWfyDbx2dd1u5SPwdzPVuRXZJ0L1T4Wk0
Message-ID: <CALa+Y14TRzSx3hJ0rLOH2dWC3kvKVOFws4VpQmKmJ-gWw_6ECg@mail.gmail.com>
Subject: Re: [PATCH qemu v4 1/5] qapi: cxl: Refactor CXL event injection for
 common commands arguments
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org, shiju.jose@huawei.com, 
	armbru@redhat.com, linuxarm@huawei.com, linux-cxl@vger.kernel.org, 
	Ravi Shankar <venkataravis@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:21=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Refactor CXL event injection to use struct for common command
> arguments.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v3: Fix wrong comment for memory module event (Markus)
> ---
>  qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 31 deletions(-)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index eeddb58d1d3f..55a088586e53 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -31,11 +31,10 @@
>   }
>
>  ##
> -# @cxl-inject-general-media-event:
> +# @CXLCommonEventBase:
>  #
> -# Inject an event record for a General Media Event (CXL r3.0
> -# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> -# specified via the log parameter.
> +# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> +# Table 8-42 Common Event Record Format).
>  #
>  # @path: CXL type 3 device canonical QOM path
>  #
> @@ -44,6 +43,16 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# Since: 8.1
> +##
> +{ 'struct': 'CXLCommonEventBase',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> +
> +##
> +# @CXLGeneralMediaEvent:
> +#
> +# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.
> @@ -74,26 +83,29 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLGeneralMediaEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>
>  ##
> -# @cxl-inject-dram-event:
> -#
> -# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> -# This event type is reported via one of the event logs specified via
> -# the log parameter.
> +# @cxl-inject-general-media-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event
> +# logs specified via the log parameter.
>  #
> -# @log: Event log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': 'CXLGeneralMediaEvent' }
> +
> +##
> +# @CXLDRAMEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
>  #
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
> @@ -133,9 +145,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> -            'dpa': 'uint64', 'descriptor': 'uint8',
> +{ 'struct': 'CXLDRAMEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint=
32',
>              '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> @@ -143,18 +155,21 @@
>             }}
>
>  ##
> -# @cxl-inject-memory-module-event:
> -#
> -# Inject an event record for a Memory Module Event (CXL r3.0
> -# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> -# at the time of the event.
> +# @cxl-inject-dram-event:
>  #
> -# @path: CXL type 3 device canonical QOM path
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
> +# This event type is reported via one of the event logs
> +# specified via the log parameter.
>  #
> -# @log: Event Log to add the event to
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': 'CXLDRAMEvent' }
> +
> +##
> +# @CXLMemModuleEvent:
>  #
> -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> -#     Record Format, Event Record Flags for subfield definitions.
> +# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
>  #
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
> @@ -185,9 +200,9 @@
>  #
>  # Since: 8.1
>  ##
> -{ 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> -            'type': 'uint8', 'health-status': 'uint8',
> +{ 'struct': 'CXLMemModuleEvent',
> +  'base': 'CXLCommonEventBase',
> +  'data': { 'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',
>              'dirty-shutdown-count': 'uint32',
> @@ -195,6 +210,18 @@
>              'corrected-persistent-error-count': 'uint32'
>              }}
>
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0
> +# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
> +# at the time of the event.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': 'CXLMemModuleEvent' }
> +
>  ##
>  # @cxl-inject-poison:
>  #
> --
> 2.48.1
>
>
No comments.

Reviewed-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
