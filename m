Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D216DEA9
	for <linux-cxl@vger.kernel.org>; Sat, 21 Dec 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734808733; cv=none; b=LpB2UuPKzr8TZqzJndFkd3mMO2qg+Odsm/2Al6Nz35ku5+MYXTt0GfrCg4cdDz1OqCSZX3aHhGjgsaoJ2tRdwyIKcaAtMbQA+gdsEeeSFMpqNa2JC1qpQXHeTykHCy73LyJQGINu596VJEqDoIyk5NdyAE4aQO7wS7tmY6vZ3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734808733; c=relaxed/simple;
	bh=uPLQKVeVmDt9PvJyae10oh4Q67O/KymKa3EjmJGimuo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvuc47ZchgmqO8sKOQGJ5KxBIoXYIKmNrPu/doI4RGkOLYNMCj/D/btWq6lOZbb+Ql9TI0kp0IjIMM4DqPrnB6YSJIQUTE0jbIrk83PCb9yFKKYFgbJRBUuqrob/ldTk5daABNjgRNoZS8ErItzCZ6tnnG4cN+z/DHEX5pvUQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDssC7b+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDssC7b+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21636268e43so34436555ad.2
        for <linux-cxl@vger.kernel.org>; Sat, 21 Dec 2024 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734808731; x=1735413531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDyIsppjeOFj+Dsc61qD2LAOYWXr+lItKTAkbMRVaB0=;
        b=YDssC7b+qHMIC5AEhTuHiOrsvMrTOt+4CCzMqVAsGYYJDfNTzp/zkGqtmfMh2wszd+
         spEIO9YiQ6cXduQwvHw9axzCMvj2iR+G/JvyYlEeCRSaTaRZFPOA/qir7CoMMpjvgZmH
         cNPjyXMbqrjAAV1I+i0h1f7SNSXHCvLFkBgIY78GDwJh054x8nWsMuHeEtGnY7y/q7uR
         6hydlIPv/rxPBcFcfwXT/ob0Gpqv8Sm6x3Pv5iAjC4sHhL7OZ94vFz5oqD7GHixfPkqV
         RJrnNaUo8XXi7KPCQEVRxR80ypsHj4hp62iM0rRaHQ5OKLGddChIWRBEMmJ+kz0MJ+Ok
         v0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734808731; x=1735413531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDyIsppjeOFj+Dsc61qD2LAOYWXr+lItKTAkbMRVaB0=;
        b=IuUq26mcLwsZlP5LOiDvH5ih9HKtbf54mE4uS+rJiD2BpRbGK7hy1Np41Hzq3cI8JA
         ELzCI4VQX9fgBHYabtnYUudkWKTWNyPjDVxt3PF6rwUOHqOVLmLXw1jy7e6+++NAB9sP
         195tEkXCgCDLf2Ug7ZtbeDIZpqHa//UHizHDqVlofn6+2xg1I0mfHf1USHTtAxpKz9/3
         JmZzQbdS7MWROR4aqK9y7Fh9M9hsiXt2tFXptOSCv1bV5N5c0qojCv9X61nH5bi/sAel
         gv0TP+1eOaQpflfp9KkbOATbNe0z+KDcVv9Ju6HtHUmLRPS+2se8oigKEfmi3AQRw6kJ
         msvA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Wp7e1V6rb1KAdnl39Zbd5AfCCK4dhxaZeg9gMggQQH+2B3EZ3iPsD1yvpsreHkVSlKA1vrr/C0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUHam0hjFqeMYIKSGyvXtrxYpwH6Biu2KSvNDixPIGG+Q/3GB
	TSJsTuBL2aO0d8vIWM6rePRbi/4P1M3/m0+shU1eUR6+Vcufdr3L
X-Gm-Gg: ASbGncvyQ/nPXBsyaxkGcU83Gljfk8nPA0YDqRwJmtVZsnNyG42mFMqQvYg3Ugv9Y3C
	8Zax+7RP/+GymyyTQ6uR+DMVlmRnlqvlNH2vafASXwT1F0OYDWHmj6WSWJbaKZnSGLtJjx2EoDs
	hljRK2Yiqmql1kp/cOcEXpme8wcAaSR9w+QZECFTZQRbXoKzWgzEj2T+StQ+xYLSOU8FXLh03LG
	OPcQ80vVff/8IpctyQ2aXw8sb/SimjvmRGp9OXB0tCPhR4=
X-Google-Smtp-Source: AGHT+IEkv6pF03KYhJwplT9VQLOHik8YCc98cganq5Oj4vvwPRNomYZ3r+xah6ANTQTLvHPQ37NVkg==
X-Received: by 2002:a17:903:2c6:b0:216:3c36:69a7 with SMTP id d9443c01a7336-219e6f262admr104778365ad.45.1734808730738;
        Sat, 21 Dec 2024 11:18:50 -0800 (PST)
Received: from gpd ([2601:646:8f03:9fee:1eca:6066:421d:7396])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d15sm47531175ad.11.2024.12.21.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 11:18:50 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Sat, 21 Dec 2024 11:18:48 -0800
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl: Support Get/Set Shutdown State commands
Message-ID: <Z2cUmMEh433UjgKm@gpd>
References: <20241220160026.204055-1-dave@stgolabs.net>
 <20241220160026.204055-3-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220160026.204055-3-dave@stgolabs.net>

On Fri, Dec 20, 2024 at 08:00:25AM -0800, Davidlohr Bueso wrote:
> As per the latest spec, add mailbox commands 4203h and 4204h.
> While upon reboot this operation is obviously a nop (flag is
> cleared but the dirty shutdown count is not increased), it
> can still serve to test some basic paths.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

...

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 49 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  2 ++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f6f993e7bc4f..ff1d3f50610c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -86,6 +86,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_SHUTDOWN_STATE     0x3
> +        #define SET_SHUTDOWN_STATE     0x4
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> @@ -1721,6 +1724,48 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +/* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
> +static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    struct get_shutdown_state_pl {
> +        uint8_t state;
> +    } QEMU_PACKED;
> +    struct get_shutdown_state_pl *out = (void *)payload_out;
> +
> +    out->state = cxl_dstate->shutdown_state;
> +    *len_out = sizeof(out);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.2 Section 8.2.10.9.3.5: Set Shutdown State (Opcode 4204h) */
> +static CXLRetCode cmd_health_set_shutdown_state(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    struct set_shutdown_state_pl {
> +        uint8_t state;
> +    } QEMU_PACKED;
> +    struct set_shutdown_state_pl *in = (void *)payload_in;

Do we need to check the input size and return invalid input payload
size?

> +
> +    cxl_dstate->shutdown_state = in->state;
> +    *len_out = 0;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -2866,6 +2911,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
> +    [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
> +        cmd_health_get_shutdown_state, 0, 0 },
> +    [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
> +        cmd_health_set_shutdown_state, 1, 0 },

Per the spec, I think the return value should be CXL_MBOX_IMMEDIATE_POLICY_CHANGE.

Fan
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25e9..69e6330fe66d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -292,6 +292,8 @@ typedef struct cxl_device_state {
>      CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
>      CHMUState chmu[1];
>      CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
> +
> +    uint8_t shutdown_state;
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */
> -- 
> 2.39.5
> 
