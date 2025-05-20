Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA424A043
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755463; cv=none; b=TAlqY/K+fMW5Nxdm2pDGLN3MER7GpLXME1TbFEgXPCq8TGQ8dbqYb8n59ceoNncrWUpx2BIToBehsn2+fWmjAfzYbvfxnfI23Z+RPfGs6WCI6lNq2aZThJzxoLV8hXWOmhQPNN6bx8+ua8QW6rgQE6ubq+ayTnWJveVvjPkbb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755463; c=relaxed/simple;
	bh=H20tgsBOg7onlrbyqWnpIgIrA57NWEL4YK23Qs4+wow=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss43bzGGwiV/wOK8OHc0jk+Tai/EJjSZUjH4UBL3VxQl/uFeDqzNCk90PUBeBsWmfwIeFaAdKouOkwP2XzjxWbcULYegd/yOPOVKPEDArAQt6P8aEG25ajWl4w1FTE2d7aiy5WJBou8m7ogeV/VYi3//e3WJaxp7dq/yrkjFcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka+2DHw3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka+2DHw3"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso7307391b3a.2
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755461; x=1748360261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfUgbG7wlz+ybzD3R782KbS9QXsdGRcz+HFsWFmMcKY=;
        b=ka+2DHw3ukws/uhV/HcjChqXuRngBRZigUnQ8RPx58rWC+R93IYTZa8BRJZ+p2Dr8b
         IrxjePAjRALu3t1kdVawAjWiHclU3ZuTPG2YxC6vrm4pAGzEsSd0gcfmk80RmVqLvjtg
         b6IBz/idb0PusIjB1ESfM3aLR66os2Uw3SF0AI998TsiEFHOaXZQtuBU6VDogudSW0bY
         7xav85URcRInr+5UOnAeDiHCm+2ajy0M9QZAGso4yFhSL6adLoD/Jt+y7AwgNWNeJZRl
         pgBY8JU5v0RAMafDlk9bxZmrETL23A2ip1R8VS8jUW5oZG9WsZQxh6Faw/S8vreRlzM3
         8MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755461; x=1748360261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfUgbG7wlz+ybzD3R782KbS9QXsdGRcz+HFsWFmMcKY=;
        b=bPEHxBwxijMKcHJtqtXE2F4yLHuS9vdl6f0QA/Xbw4LYqKxORzJMqxWP2+dvyQKXrQ
         n6QBtezP+pqWjh2/7y/BgR6HCuuHDml9O/XMMjJnxVN7Oy1zR7GbfMZraod1K2lHFbbh
         YW0loaB8o2DssQBuzG0LjNFM2GXCkj/DlLuxmosOEJJkA6poclNixh+cgK58Mi2Zu2uj
         fRZ2YiM92iWkmEWrdZGpc8id3s1i+vTd0SfvbW9hCMspMhhUpSXqCOUsw4Q+/63CkBqO
         r+s1UCqM6Io8j2ZS81AA7OtWCcBfcUGYlGMeCDqWSFwfURSoKueaqjgXmozGEg3M2I7l
         Nqag==
X-Forwarded-Encrypted: i=1; AJvYcCVN7Da/c2baFhnv3oXx7EpFSV78e4MhJp87dfJsPA5s6oAnRADurAZPTqAWjNMH7LCcWOueRQtwYwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdxRpqI7j7KwTkgA82mbYpBTYyvpDe8dml8MhSKMYvG5j8N9y
	9Oku93LFa8hTNNeHP61OqWnMbj0XaFq8sh2NAyT89VT7n9ZcKyGPEhNHTzf+bg==
X-Gm-Gg: ASbGncvahAmDylvYlE+B4cjD19lLEjpBbbSvF+r3YrkG6qRUpzmYntaBOFFzx3HhNT1
	9HX+vVqO8ciU68hdCimlKyAl+WCRI75LF7HfNUJpQaLFaPqfVXHr/7gdOGoRlxl7R8YIuzcoYVi
	GbD8qKTCk+yOICTqNXknfrmCANQPMniy+Anzkx6e9sBn1VQdcuUFjEz0vo9/m7VghkAoF5wQxtI
	eo/KHVPbCLcp+Y4MHRTVbaTpUsajFpMR5JH7/FWSNitq3u7ZWJBwA5nSuUR5hcCy3ZnnbQt6UxU
	SXQ/QDKFJuRYU23qscmX7KtyWEUpdlpgTtxTgRth1d/fSsJJ7F70
X-Google-Smtp-Source: AGHT+IEwSkvU591UJhbKnDRmu73swl+LkaJvyIbpoNTzQIdAkiru/cpM8OObscQjElXrRH2kNDBEOQ==
X-Received: by 2002:a05:6a00:3492:b0:742:9bd3:cd1f with SMTP id d2e1a72fcca58-742acd728eamr21638969b3a.23.1747755461288;
        Tue, 20 May 2025 08:37:41 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739906sm8071440b3a.80.2025.05.20.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:37:40 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 08:37:35 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aCyhv8Qz1LUpJKd3@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-2-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> certain command sets are bound with the correct MCTP binding.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
>  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++

Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
creating a new file. cxl_mailbox.h only has some macros.

Fan



>  2 files changed, 66 insertions(+), 66 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_opcodes.h
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a02d130926..ed3294530f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -23,6 +23,7 @@
>  #include "qemu/uuid.h"
>  #include "system/hostmem.h"
>  #include "qemu/range.h"
> +#include "hw/cxl/cxl_opcodes.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> @@ -36,7 +37,7 @@
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> - *  1. Add the command set and cmd to the enum.
> + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
>   *     FOO    = 0x7f,
>   *          #define BAR 0
>   *  2. Implement the handler
> @@ -59,71 +60,6 @@
>   *  a register interface that already deals with it.
>   */
>  
> -enum {
> -    INFOSTAT    = 0x00,
> -        #define IS_IDENTIFY   0x1
> -        #define BACKGROUND_OPERATION_STATUS    0x2
> -        #define GET_RESPONSE_MSG_LIMIT         0x3
> -        #define SET_RESPONSE_MSG_LIMIT         0x4
> -        #define BACKGROUND_OPERATION_ABORT     0x5
> -    EVENTS      = 0x01,
> -        #define GET_RECORDS   0x0
> -        #define CLEAR_RECORDS   0x1
> -        #define GET_INTERRUPT_POLICY   0x2
> -        #define SET_INTERRUPT_POLICY   0x3
> -    FIRMWARE_UPDATE = 0x02,
> -        #define GET_INFO      0x0
> -        #define TRANSFER      0x1
> -        #define ACTIVATE      0x2
> -    TIMESTAMP   = 0x03,
> -        #define GET           0x0
> -        #define SET           0x1
> -    LOGS        = 0x04,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_LOG       0x1
> -        #define GET_LOG_CAPABILITIES   0x2
> -        #define CLEAR_LOG     0x3
> -        #define POPULATE_LOG  0x4
> -    FEATURES    = 0x05,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_FEATURE   0x1
> -        #define SET_FEATURE   0x2
> -    IDENTIFY    = 0x40,
> -        #define MEMORY_DEVICE 0x0
> -    CCLS        = 0x41,
> -        #define GET_PARTITION_INFO     0x0
> -        #define GET_LSA       0x2
> -        #define SET_LSA       0x3
> -    HEALTH_INFO_ALERTS = 0x42,
> -        #define GET_ALERT_CONFIG 0x1
> -        #define SET_ALERT_CONFIG 0x2
> -    SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> -        #define MEDIA_OPERATIONS 0x2
> -    PERSISTENT_MEM = 0x45,
> -        #define GET_SECURITY_STATE     0x0
> -    MEDIA_AND_POISON = 0x43,
> -        #define GET_POISON_LIST        0x0
> -        #define INJECT_POISON          0x1
> -        #define CLEAR_POISON           0x2
> -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> -        #define SCAN_MEDIA             0x4
> -        #define GET_SCAN_MEDIA_RESULTS 0x5
> -    DCD_CONFIG  = 0x48,
> -        #define GET_DC_CONFIG          0x0
> -        #define GET_DYN_CAP_EXT_LIST   0x1
> -        #define ADD_DYN_CAP_RSP        0x2
> -        #define RELEASE_DYN_CAP        0x3
> -    PHYSICAL_SWITCH = 0x51,
> -        #define IDENTIFY_SWITCH_DEVICE      0x0
> -        #define GET_PHYSICAL_PORT_STATE     0x1
> -    TUNNEL = 0x53,
> -        #define MANAGEMENT_COMMAND     0x0
> -    MHD = 0x55,
> -        #define GET_MHD_INFO 0x0
> -};
> -
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>  typedef struct CXLCCIMessage {
>      uint8_t category;
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> new file mode 100644
> index 0000000000..26d3a99e8a
> --- /dev/null
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -0,0 +1,64 @@
> +enum {
> +    INFOSTAT    = 0x00,
> +        #define IS_IDENTIFY   0x1
> +        #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT         0x3
> +        #define SET_RESPONSE_MSG_LIMIT         0x4
> +        #define BACKGROUND_OPERATION_ABORT     0x5
> +    EVENTS      = 0x01,
> +        #define GET_RECORDS   0x0
> +        #define CLEAR_RECORDS   0x1
> +        #define GET_INTERRUPT_POLICY   0x2
> +        #define SET_INTERRUPT_POLICY   0x3
> +    FIRMWARE_UPDATE = 0x02,
> +        #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
> +    TIMESTAMP   = 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
> +    LOGS        = 0x04,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
> +        #define CLEAR_LOG     0x3
> +        #define POPULATE_LOG  0x4
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
> +    IDENTIFY    = 0x40,
> +        #define MEMORY_DEVICE 0x0
> +    CCLS        = 0x41,
> +        #define GET_PARTITION_INFO     0x0
> +        #define GET_LSA       0x2
> +        #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIG 0x1
> +        #define SET_ALERT_CONFIG 0x2
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0
> +        #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
> +    PERSISTENT_MEM = 0x45,
> +        #define GET_SECURITY_STATE     0x0
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
> +    PHYSICAL_SWITCH = 0x51,
> +        #define IDENTIFY_SWITCH_DEVICE      0x0
> +        #define GET_PHYSICAL_PORT_STATE     0x1
> +    TUNNEL = 0x53,
> +        #define MANAGEMENT_COMMAND     0x0
> +    MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +};
> -- 
> 2.47.2
> 

-- 
Fan Ni
