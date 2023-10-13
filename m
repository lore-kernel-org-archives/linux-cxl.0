Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8D219E6
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X39OI60H"
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3851D6
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:56:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so660159a12.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697216206; x=1697821006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgV73/bZCE+j0pcmpLO58sQXuQXF3ja23XLyZlWF1ew=;
        b=X39OI60HQxVw94hqIeSW2bblTDgnLT9+znzmhG1vJbSEnJOFKBuGdKEmBpDM192li7
         Br4+Ww7eaAaK1Wqk3rb0Gbqd5wqD9wvFSplMFqsjfT9QcpQEi4le3LNGTx2RpCtwmARQ
         VxeuQ7SrbtawaxFuLwppZq5HE1o/+c1v7Xgew4OlutguoO73dNVkuuI/rUJgfqrU+8Kf
         JsW8Y/2wsyYRcqhgexOwZ+NcRVIUI58Msl5GBR4dtiivd24tpxWowBMOPPVlGf6Vd5no
         DtjStR8WD9f3E9EnHub2U78wMEMIG5BTmhWW/w6Fi9tasbvz4UJspPQGS4fx8m5iK7xL
         Seag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697216206; x=1697821006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgV73/bZCE+j0pcmpLO58sQXuQXF3ja23XLyZlWF1ew=;
        b=PBcBsi2yhFj6XALKfaH1CFHDyNLXyHT392GMrQ7yK+IDPiafFLUUIs2R1ie5LrEKYx
         fJk/ac86Rzs2RCpY0tl9/0Oag3g0v6H82ecbR5dYloPw/DgBmeOH2E92dJJ/Bicz5tjV
         gj2PzLloFMDi/gxOxNB2S4exEy0Zq+F1d5mj8Ek3d8KAlE19AdspbZ01s6EUl26fvYLV
         bziqHxPPpC2PhX93bH5gRwDW08SZuxNPTUf0inpFG+gh4oi07AuLC1u0s9RRkAJGt40A
         DJRvnSk5t8gtRLUarc6YmZG3MKw7UL9RbdycLocui0bZxa5Kf5WZ/Vu+MkilDLxPbDAo
         7Kow==
X-Gm-Message-State: AOJu0YwiAe7gcVotzjPkZSBdwLUOz0lY7AdJGeS3+CR5PxCwIQIMoOpn
	EP4QcnWkKil3ObLyy8Nj6js=
X-Google-Smtp-Source: AGHT+IFncI/OCutdaHnUhGVL+zFM1t5prtTsGtePoM6du2LSGUuNHMw9Ml2EEe+dn1yZUdX1ZJc6zw==
X-Received: by 2002:a05:6a20:734b:b0:14c:de3:95d6 with SMTP id v11-20020a056a20734b00b0014c0de395d6mr28410653pzc.45.1697216206080;
        Fri, 13 Oct 2023 09:56:46 -0700 (PDT)
Received: from debian (99-13-228-231.lightspeed.snjsca.sbcglobal.net. [99.13.228.231])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001c74df14e6esm4124080plk.51.2023.10.13.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:56:45 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 13 Oct 2023 09:56:09 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Michael Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	linuxarm@huawei.com, Fan Ni <fan.ni@samsung.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 4/4] hw/cxl: Line length reductions
Message-ID: <ZSl2k_-hyzcC60CX@debian>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012140514.3697-5-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 03:05:14PM +0100, Jonathan Cameron wrote:
> Michael Tsirkin observed that there were some unnecessarily
> long lines in the CXL code in a recent review.
> This patch is intended to rectify that where it does not
> hurt readability.
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/hw/cxl/cxl_component.h |  3 ++-
>  include/hw/cxl/cxl_device.h    |  5 +++--
>  include/hw/cxl/cxl_events.h    |  3 ++-
>  hw/cxl/cxl-cdat.c              |  3 ++-
>  hw/cxl/cxl-component-utils.c   | 14 ++++++++------
>  hw/cxl/cxl-events.c            |  9 ++++++---
>  hw/cxl/cxl-mailbox-utils.c     | 21 ++++++++++++++-------
>  hw/mem/cxl_type3.c             | 31 +++++++++++++++++++------------
>  hw/mem/cxl_type3_stubs.c       |  5 +++--
>  9 files changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 3c795a6278..e52dd8d2b9 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -175,7 +175,8 @@ HDM_DECODER_INIT(3);
>      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
>  #define CXL_SNOOP_REGISTERS_SIZE   0x8
>  
> -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
> +QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> +                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
>                     "No space for registers");
>  
>  typedef struct component_registers {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 51cd0d9ce3..007ddaf078 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -192,7 +192,7 @@ void cxl_device_register_init_common(CXLDeviceState *dev);
>   * Documented as a 128 bit register, but 64 bit accesses and the second
>   * 64 bits are currently reserved.
>   */
> -REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte accesses */
> +REG64(CXL_DEV_CAP_ARRAY, 0)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
> @@ -361,7 +361,8 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> -    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset,
> +                          uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..d778487b7e 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -92,7 +92,8 @@ typedef enum CXLEventIntMode {
>      CXL_INT_RES      = 0x03,
>  } CXLEventIntMode;
>  #define CXL_EVENT_INT_MODE_MASK 0x3
> -#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
> +#define CXL_EVENT_INT_SETTING(vector) \
> +    ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
>  typedef struct CXLEventInterruptPolicy {
>      uint8_t info_settings;
>      uint8_t warn_settings;
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index d246d6885b..639a2db3e1 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -60,7 +60,8 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>          return;
>      }
>  
> -    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf, cdat->private);
> +    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
> +                                                 cdat->private);
>  
>      if (!cdat->built_buf_len) {
>          /* Build later as not all data available yet */
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 8ab04dbb01..80efbf6365 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -240,7 +240,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     POISON_ON_ERR_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> @@ -263,15 +264,16 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      }
>  }
>  
> -void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk,
> +void cxl_component_register_init_common(uint32_t *reg_state,
> +                                        uint32_t *write_msk,
>                                          enum reg_type type)
>  {
>      int caps = 0;
>  
>      /*
> -     * In CXL 2.0 the capabilities required for each CXL component are such that,
> -     * with the ordering chosen here, a single number can be used to define
> -     * which capabilities should be provided.
> +     * In CXL 2.0 the capabilities required for each CXL component are such
> +     * that, with the ordering chosen here, a single number can be used to
> +     * define which capabilities should be provided.
>       */
>      switch (type) {
>      case CXL2_DOWNSTREAM_PORT:
> @@ -448,7 +450,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
>          default: /* Registers are RO for other component types */
>              break;
>          }
> -        /* There are rw1cs bits in the status register but never set currently */
> +        /* There are rw1cs bits in the status register but never set */
>          break;
>      }
>  
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 3ddd6369ad..e2172b94b9 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -170,8 +170,10 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>      if (log->overflow_err_count) {
>          pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
>          pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
> -        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
> -        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
> +        pl->first_overflow_timestamp =
> +            cpu_to_le64(log->first_overflow_timestamp);
> +        pl->last_overflow_timestamp =
> +            cpu_to_le64(log->last_overflow_timestamp);
>      }
>  
>      pl->record_count = cpu_to_le16(nr);
> @@ -180,7 +182,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
> +CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
> +                                   CXLClearEventPayload *pl)
>  {
>      CXLEventLog *log;
>      uint8_t log_type;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 434ccc5f6e..ab082ec9de 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -366,9 +366,12 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> -    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> -    stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> -    stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->total_capacity,
> +             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->persistent_capacity,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->volatile_capacity,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
>      /* 256 poison records */
>      st24_le_p(id->poison_list_max_mer, 256);
> @@ -396,13 +399,15 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> -    stq_le_p(&part_info->active_vmem, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&part_info->active_vmem,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      /*
>       * When both next_vmem and next_pmem are 0, there is no pending change to
>       * partitioning.
>       */
>      stq_le_p(&part_info->next_vmem, 0);
> -    stq_le_p(&part_info->active_pmem, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&part_info->active_pmem,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&part_info->next_pmem, 0);
>  
>      *len = sizeof(*part_info);
> @@ -681,8 +686,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> -    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
> -    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
> +    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> +                         8, IMMEDIATE_POLICY_CHANGE },
> +    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> +                              0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c02be4ce45..18ad853f5b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -208,10 +208,9 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      if (nonvolatile_mr) {
> +        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
>          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true,
> -                                           (volatile_mr ?
> -                                            memory_region_size(volatile_mr) : 0));
> +                                           nonvolatile_mr, true, base);
>          if (rc < 0) {
>              goto error_cleanup;
>          }
> @@ -514,7 +513,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      case A_CXL_RAS_UNC_ERR_STATUS:
>      {
>          uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> -        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
> +        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                 FIRST_ERROR_POINTER);
>          CXLError *cxl_err;
>          uint32_t unc_err;
>  
> @@ -533,7 +533,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>                   * closest to behavior of hardware not capable of multiple
>                   * header recording.
>                   */
> -                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cxl_next) {
> +                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node,
> +                                    cxl_next) {
>                      if ((1 << cxl_err->type) & value) {
>                          QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
>                          g_free(cxl_err);
> @@ -1072,7 +1073,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>          if (((start >= p->start) && (start < p->start + p->length)) ||
>              ((start + length > p->start) &&
>               (start + length <= p->start + p->length))) {
> -            error_setg(errp, "Overlap with existing poisoned region not supported");
> +            error_setg(errp,
> +                       "Overlap with existing poisoned region not supported");
>              return;
>          }
>      }
> @@ -1085,7 +1087,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>      p = g_new0(CXLPoison, 1);
>      p->length = length;
>      p->start = start;
> -    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
> +    /* Different from injected via the mbox */
> +    p->type = CXL_POISON_TYPE_INTERNAL;
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> @@ -1222,7 +1225,8 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>          return;
>      }
>      /* If the error is masked, nothting to do here */
> -    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
> +    if (!((1 << cxl_err_type) &
> +          ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
>          return;
>      }
>  
> @@ -1372,7 +1376,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *correction_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1473,7 +1478,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_error_count,
> -                                        uint32_t corrected_persistent_error_count,
> +                                        uint32_t corrected_persist_error_count,
>                                          Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1513,8 +1518,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      module.life_used = life_used;
>      stw_le_p(&module.temperature, temperature);
>      stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
> -    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
> -    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
> +    stl_le_p(&module.corrected_volatile_error_count,
> +             corrected_volatile_error_count);
> +    stl_le_p(&module.corrected_persistent_error_count,
> +             corrected_persist_error_count);
>  
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
>          cxl_event_irq_assert(ct3d);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 8ba5d3d1f7..3e1851e32b 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -33,7 +33,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *correction_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp) {}
>  
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> @@ -45,7 +46,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_error_count,
> -                                        uint32_t corrected_persistent_error_count,
> +                                        uint32_t corrected_persist_error_count,
>                                          Error **errp) {}
>  
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> -- 
> 2.39.2
> 
