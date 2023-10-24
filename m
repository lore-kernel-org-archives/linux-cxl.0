Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E36241E1
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Tq9+k1"
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DAAF
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 09:53:07 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a8628e54d4so40341557b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166387; x=1698771187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLGCIqtj7uBldYK7Hk1vDmPA5/pHNdBPDJX3sgRsX3g=;
        b=Z8Tq9+k1W+B+4tHCy8zYdwdZWbIBzllfI0PX1l1n92vFpmCVChS8m/EvX8z0VDsc6e
         DQTPbQv7X/QB2KgLpmDrYkGHzlIV+xKacdCE66CpQ1x3rYvF0z8UzlW7TpcWL4/zSHrP
         AfQG6+a7UYaj5w3FTRH4y1jI7qPMBUIt6W4hvMbSd/sdTneF/2gyjLOzGjUWJgLSIH8W
         0GHiJIZnXMv7ftAXW21T8GA1ArE5cRpqKd++Z349EqjdwVsBr0iDt9cvdWZJjeJf7u9l
         9LyL7WZQNC7P/0iAthkmmwSxd4sxrhdTqketpMXQ+sCmuVlOB1VFKS9+N8mxxn6PgbGJ
         1iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166387; x=1698771187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLGCIqtj7uBldYK7Hk1vDmPA5/pHNdBPDJX3sgRsX3g=;
        b=jNN13/C52fuPngat9hAmbyXMYdZ/3IRT0NuDdchGAhVi+5ZBYf/+9Dn0K/GRab1dur
         spO9DrOh5T34Z/knkB2KxxINZAOCQnACS6qfMiuIrRMclao2cSx7atjJNK0ibL7zH09i
         wlmDFCVslFQOAPsY0yFTfifEvZ9N6Q6spl8JTsEZ2OEIvQ1LHxDoWHpBsqyBfl93WX53
         8nuUVfjjw8AlrlGdUqsVenm1hbhAK6i4tIhT2YwGQIzyHs99lsBHVTlg6b9xN7piJ9FY
         BOLE3NcrvY9SdScZ72P4CLUPCvLv0t0vtmypLjEJDqjKEh2Z0zEq7YG6MfNduTHK0UaO
         2zOw==
X-Gm-Message-State: AOJu0YwXRzXEpwX5gm4QgSXMVKz5nE8wYkMp9bwV5L1fLj7Yih0GpbdY
	MwLGoyn65X8etTpBO/aqkzE=
X-Google-Smtp-Source: AGHT+IGE0Rly43HJTrlg8AeBZzFtcGfVSBYihmEgjU6vJUT2UxZ/Ynk/kL/ctg8yJW4wjcj9YRPOkQ==
X-Received: by 2002:a0d:cb0e:0:b0:5a7:bde8:84a4 with SMTP id n14-20020a0dcb0e000000b005a7bde884a4mr13519959ywd.14.1698166386583;
        Tue, 24 Oct 2023 09:53:06 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id a68-20020a0df147000000b005950e1bbf11sm4181530ywf.60.2023.10.24.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:53:06 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 24 Oct 2023 09:52:42 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Michael Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	linuxarm@huawei.com, Fan Ni <fan.ni@samsung.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Gregory Price <gregory.price@memverge.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Klaus Jensen <its@irrelevant.dk>,
	Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2 02/17] hw/cxl/mbox: Split mailbox command payload into
 separate input and output
Message-ID: <ZTf2WiinPhn0zWEX@debian>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
 <20231023160806.13206-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023160806.13206-3-Jonathan.Cameron@huawei.com>

On Mon, Oct 23, 2023 at 05:07:51PM +0100, Jonathan Cameron wrote:
> New CCI types that will be supported shortly do not have a single buffer
> used in both directions. As such, split it up. To avoid the complexities
> of implementing all commands to handle potential aliasing, take a copy of
> the input before use.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v2:
> - Drop Fan's RB as significant changes.
> - Avoid passing aliased pointers to the various command handlers.
>   It was a source of subtle bugs in the switch-cci so let us just make
>   a copy and use that instead.
> ---
>  include/hw/cxl/cxl_device.h |   7 +-
>  hw/cxl/cxl-events.c         |   2 +-
>  hw/cxl/cxl-mailbox-utils.c  | 230 +++++++++++++++++++++---------------
>  3 files changed, 140 insertions(+), 99 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 556953469c..d7a2c4009e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -114,8 +114,9 @@ typedef enum {
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
>  typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
> -                                     uint8_t *payload,
> -                                     CXLDeviceState *cxl_dstate, uint16_t *len);
> +                                     uint8_t *payload_in, size_t len_in,
> +                                     uint8_t *payload_out, size_t *len_out,
> +                                     CXLDeviceState *cxl_dstate);
>  struct cxl_cmd {
>      const char *name;
>      opcode_handler handler;
> @@ -390,7 +391,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>                        CXLEventRecordRaw *event);
>  CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>                                   uint8_t log_type, int max_recs,
> -                                 uint16_t *len);
> +                                 size_t *len);
>  CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>                                     CXLClearEventPayload *pl);
>  
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index e2172b94b9..bee6dfaf14 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -143,7 +143,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>  
>  CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>                                   uint8_t log_type, int max_recs,
> -                                 uint16_t *len)
> +                                 size_t *len)
>  {
>      CXLEventLog *log;
>      CXLEvent *entry;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c02de06943..e5ddce37c7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -71,9 +71,9 @@ enum {
>  
>  
>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxlds,
> -                                         uint16_t *len)
> +                                         uint8_t *payload_in, size_t len_in,
> +                                         uint8_t *payload_out, size_t *len_out,
> +                                         CXLDeviceState *cxlds)
>  {
>      CXLGetEventPayload *pl;
>      uint8_t log_type;
> @@ -83,9 +83,9 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -    log_type = payload[0];
> +    log_type = payload_in[0];
>  
> -    pl = (CXLGetEventPayload *)payload;
> +    pl = (CXLGetEventPayload *)payload_out;
>      memset(pl, 0, sizeof(*pl));
>  
>      max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
> @@ -94,30 +94,34 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>          max_recs = 0xFFFF;
>      }
>  
> -    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
> +    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len_out);
>  }
>  
>  static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
> -                                           uint8_t *payload,
> -                                           CXLDeviceState *cxlds,
> -                                           uint16_t *len)
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLDeviceState *cxlds)
>  {
>      CXLClearEventPayload *pl;
>  
> -    pl = (CXLClearEventPayload *)payload;
> -    *len = 0;
> +    pl = (CXLClearEventPayload *)payload_in;
> +    *len_out = 0;
>      return cxl_event_clear_records(cxlds, pl);
>  }
>  
>  static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
> -                                                  uint8_t *payload,
> -                                                  CXLDeviceState *cxlds,
> -                                                  uint16_t *len)
> +                                                  uint8_t *payload_in,
> +                                                  size_t len_in,
> +                                                  uint8_t *payload_out,
> +                                                  size_t *len_out,
> +                                                  CXLDeviceState *cxlds)
>  {
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
>  
> -    policy = (CXLEventInterruptPolicy *)payload;
> +    policy = (CXLEventInterruptPolicy *)payload_out;
>      memset(policy, 0, sizeof(*policy));
>  
>      log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
> @@ -146,23 +150,25 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
>          policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
>      }
>  
> -    *len = sizeof(*policy);
> +    *len_out = sizeof(*policy);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
> -                                                  uint8_t *payload,
> -                                                  CXLDeviceState *cxlds,
> -                                                  uint16_t *len)
> +                                                  uint8_t *payload_in,
> +                                                  size_t len_in,
> +                                                  uint8_t *payload_out,
> +                                                  size_t *len_out,
> +                                                  CXLDeviceState *cxlds)
>  {
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
>  
> -    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
> +    if (len_in < CXL_EVENT_INT_SETTING_MIN_LEN) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
>  
> -    policy = (CXLEventInterruptPolicy *)payload;
> +    policy = (CXLEventInterruptPolicy *)payload_in;
>  
>      log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
>      log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
> @@ -181,7 +187,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
>                          CXL_INT_MSI_MSIX;
>  
>      /* DCD is optional */
> -    if (*len < sizeof(*policy)) {
> +    if (len_in < sizeof(*policy)) {
>          return CXL_MBOX_SUCCESS;
>      }
>  
> @@ -189,15 +195,17 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
>      log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
>                          CXL_INT_MSI_MSIX;
>  
> -    *len = sizeof(*policy);
> +    *len_out = 0;
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  /* 8.2.9.2.1 */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> -                                               uint8_t *payload,
> -                                               CXLDeviceState *cxl_dstate,
> -                                               uint16_t *len)
> +                                               uint8_t *payload_in,
> +                                               size_t len,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint8_t slots_supported;
> @@ -216,7 +224,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> -    fw_info = (void *)payload;
> +    fw_info = (void *)payload_out;
>      memset(fw_info, 0, sizeof(*fw_info));
>  
>      fw_info->slots_supported = 2;
> @@ -224,36 +232,40 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>      fw_info->caps = 0;
>      pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
>  
> -    *len = sizeof(*fw_info);
> +    *len_out = sizeof(*fw_info);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  /* 8.2.9.3.1 */
>  static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
> -                                    uint8_t *payload,
> -                                    CXLDeviceState *cxl_dstate,
> -                                    uint16_t *len)
> +                                    uint8_t *payload_in,
> +                                    size_t len_in,
> +                                    uint8_t *payload_out,
> +                                    size_t *len_out,
> +                                    CXLDeviceState *cxl_dstate)
>  {
>      uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
>  
> -    stq_le_p(payload, final_time);
> -    *len = 8;
> +    stq_le_p(payload_out, final_time);
> +    *len_out = 8;
>  
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  /* 8.2.9.3.2 */
>  static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
> -                                    uint8_t *payload,
> -                                    CXLDeviceState *cxl_dstate,
> -                                    uint16_t *len)
> +                                    uint8_t *payload_in,
> +                                    size_t len_in,
> +                                    uint8_t *payload_out,
> +                                    size_t *len_out,
> +                                    CXLDeviceState *cxl_dstate)
>  {
>      cxl_dstate->timestamp.set = true;
>      cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>  
> -    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload);
> +    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload_in);
>  
> -    *len = 0;
> +    *len_out = 0;
>      return CXL_MBOX_SUCCESS;
>  }
>  
> @@ -265,9 +277,11 @@ static const QemuUUID cel_uuid = {
>  
>  /* 8.2.9.4.1 */
>  static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxl_dstate,
> -                                         uint16_t *len)
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint16_t entries;
> @@ -276,22 +290,24 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
>              QemuUUID uuid;
>              uint32_t size;
>          } log_entries[1];
> -    } QEMU_PACKED *supported_logs = (void *)payload;
> +    } QEMU_PACKED *supported_logs = (void *)payload_out;
>      QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
>  
>      supported_logs->entries = 1;
>      supported_logs->log_entries[0].uuid = cel_uuid;
>      supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
>  
> -    *len = sizeof(*supported_logs);
> +    *len_out = sizeof(*supported_logs);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  /* 8.2.9.4.2 */
>  static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          QemuUUID uuid;
> @@ -299,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>          uint32_t length;
>      } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
>  
> -    get_log = (void *)payload;
> +    get_log = (void *)payload_in;
>  
>      /*
>       * 8.2.9.4.2
> @@ -323,19 +339,21 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      }
>  
>      /* Store off everything to local variables so we can wipe out the payload */
> -    *len = get_log->length;
> +    *len_out = get_log->length;
>  
> -    memmove(payload, cxl_dstate->cel_log + get_log->offset,
> -           get_log->length);
> +    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
> +            get_log->length);
>  
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  /* 8.2.9.5.1.1 */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
> -                                             uint8_t *payload,
> -                                             CXLDeviceState *cxl_dstate,
> -                                             uint16_t *len)
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          char fw_revision[0x10];
> @@ -363,7 +381,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> -    id = (void *)payload;
> +    id = (void *)payload_out;
>      memset(id, 0, sizeof(*id));
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> @@ -380,21 +398,23 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>      /* No limit - so limited by main poison record limit */
>      stw_le_p(&id->inject_poison_limit, 0);
>  
> -    *len = sizeof(*id);
> +    *len_out = sizeof(*id);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
> -                                              uint8_t *payload,
> -                                              CXLDeviceState *cxl_dstate,
> -                                              uint16_t *len)
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint64_t active_vmem;
>          uint64_t active_pmem;
>          uint64_t next_vmem;
>          uint64_t next_pmem;
> -    } QEMU_PACKED *part_info = (void *)payload;
> +    } QEMU_PACKED *part_info = (void *)payload_out;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> @@ -413,14 +433,16 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
>               cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&part_info->next_pmem, 0);
>  
> -    *len = sizeof(*part_info);
> +    *len_out = sizeof(*part_info);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint32_t offset;
> @@ -430,46 +452,47 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      uint32_t offset, length;
>  
> -    get_lsa = (void *)payload;
> +    get_lsa = (void *)payload_in;
>      offset = get_lsa->offset;
>      length = get_lsa->length;
>  
>      if (offset + length > cvc->get_lsa_size(ct3d)) {
> -        *len = 0;
> +        *len_out = 0;
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -    *len = cvc->get_lsa(ct3d, get_lsa, length, offset);
> +    *len_out = cvc->get_lsa(ct3d, payload_out, length, offset);
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct set_lsa_pl {
>          uint32_t offset;
>          uint32_t rsvd;
>          uint8_t data[];
>      } QEMU_PACKED;
> -    struct set_lsa_pl *set_lsa_payload = (void *)payload;
> +    struct set_lsa_pl *set_lsa_payload = (void *)payload_in;
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      const size_t hdr_len = offsetof(struct set_lsa_pl, data);
> -    uint16_t plen = *len;
>  
> -    *len = 0;
> -    if (!plen) {
> +    *len_out = 0;
> +    if (!len_in) {
>          return CXL_MBOX_SUCCESS;
>      }
>  
> -    if (set_lsa_payload->offset + plen > cvc->get_lsa_size(ct3d) + hdr_len) {
> +    if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
> -    plen -= hdr_len;
> +    len_in -= hdr_len;
>  
> -    cvc->set_lsa(ct3d, set_lsa_payload->data, plen, set_lsa_payload->offset);
> +    cvc->set_lsa(ct3d, set_lsa_payload->data, len_in, set_lsa_payload->offset);
>      return CXL_MBOX_SUCCESS;
>  }
>  
> @@ -480,9 +503,11 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>   * testing that kernel functionality.
>   */
>  static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
> -                                            uint8_t *payload,
> -                                            CXLDeviceState *cxl_dstate,
> -                                            uint16_t *len)
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            CXLDeviceState *cxl_dstate)
>  {
>      struct get_poison_list_pl {
>          uint64_t pa;
> @@ -502,8 +527,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
>          } QEMU_PACKED records[];
>      } QEMU_PACKED;
>  
> -    struct get_poison_list_pl *in = (void *)payload;
> -    struct get_poison_list_out_pl *out = (void *)payload;
> +    struct get_poison_list_pl *in = (void *)payload_in;
> +    struct get_poison_list_out_pl *out = (void *)payload_out;
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      uint16_t record_count = 0, i = 0;
>      uint64_t query_start, query_length;
> @@ -552,14 +577,16 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
>          stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
>      }
>      stw_le_p(&out->count, record_count);
> -    *len = out_pl_len;
> +    *len_out = out_pl_len;
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
> -                                          uint8_t *payload,
> -                                          CXLDeviceState *cxl_dstate,
> -                                          uint16_t *len_unused)
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLDeviceState *cxl_dstate)
>  {
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLPoisonList *poison_list = &ct3d->poison_list;
> @@ -567,7 +594,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
>      struct inject_poison_pl {
>          uint64_t dpa;
>      };
> -    struct inject_poison_pl *in = (void *)payload;
> +    struct inject_poison_pl *in = (void *)payload_in;
>      uint64_t dpa = ldq_le_p(&in->dpa);
>      CXLPoison *p;
>  
> @@ -592,14 +619,17 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
>       */
>      QLIST_INSERT_HEAD(poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    *len_out = 0;
>  
>      return CXL_MBOX_SUCCESS;
>  }
>  
>  static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxl_dstate,
> -                                         uint16_t *len_unused)
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLDeviceState *cxl_dstate)
>  {
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLPoisonList *poison_list = &ct3d->poison_list;
> @@ -611,7 +641,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      CXLPoison *ent;
>      uint64_t dpa;
>  
> -    struct clear_poison_pl *in = (void *)payload;
> +    struct clear_poison_pl *in = (void *)payload_in;
>  
>      dpa = ldq_le_p(&in->dpa);
>      if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> @@ -672,6 +702,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      }
>      /* Any fragments have been added, free original entry */
>      g_free(ent);
> +    *len_out = 0;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -724,15 +755,24 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  
>      uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
>      uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
> -    uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> +    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
>      uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> +    /*
> +     * Copy taken to avoid need for individual command handlers to care
> +     * about aliasing.
> +     */
> +    g_autofree uint8_t *pl_in_copy = NULL;
> +    size_t len_out = 0;
>  
> +    pl_in_copy = g_memdup2(pl, len_in);
> +    /* Avoid stale data - including from earlier commands */
> +    memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
>      cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
>      h = cxl_cmd->handler;
>      if (h) {
> -        if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
> -            ret = (*h)(cxl_cmd, pl, cxl_dstate, &len);
> -            assert(len <= cxl_dstate->payload_size);
> +        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
> +            ret = (*h)(cxl_cmd, pl_in_copy, len_in, pl, &len_out, cxl_dstate);
> +            assert(len_out <= cxl_dstate->payload_size);
>          } else {
>              ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>          }
> @@ -748,7 +788,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      /* Set the return length */
>      command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
>      command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
> -    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len);
> +    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
>  
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> -- 
> 2.39.2
> 
