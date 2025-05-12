Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4025A351
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039369; cv=none; b=mAyiRRzANeO9YdcRhcKrhnyD67P0ZE8SzQNY5oFWc1nrljtjVYRf85oIBSqJiX7pwL7qEE9QHvSUaONN308EVtxy0MlA5K5f+w6oOecKn9wIsNmMdHmlUwG+vKXHGz3AFtIaLFxgGgsED67LMgRG/Sn9KfaXbMyepzovL0IjPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039369; c=relaxed/simple;
	bh=SoVCmsfLOqCKOWfMRmiDhJ9W47s/E94RoHZ1lc5T3I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SqoqxO047ifOt0eMOcgH9lbd7Nx6xYoA8Q8YB4aGJkMl7knkvZ7ojUGI8Wndw2Sq3vFFlJvQ+LSkxTYoHY3n9MklSGwrhQsalzVJC2auJFo5NUvzH34NxjCR/dJIr2yXaoAZVQ0Z74TkgO7ifISyVsvRIyFU/oV8ImiBxxL8DE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGgt0BHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGgt0BHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747039364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6ohPqMOJcmTNEQKajOFANKaCxzi/ZzXJ8BO28MUwXQ=;
	b=NGgt0BHvhSW8RaU+9wx8BJSQwsBcM53NMRLliHwY2aEeEG6qrybF/SscoqZmgrgzDhERNO
	4ReSAfITigYh6vI/j0hSpWtU1SJb5lDCy9KcFXgZSKL/298Km4kZcEKzZq6Q235tcGqdZi
	PA+NesmtFYD4FiBKeB/YcRShETh/hwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-APlfq7fZPr-9cgSDp7TOnA-1; Mon, 12 May 2025 04:42:42 -0400
X-MC-Unique: APlfq7fZPr-9cgSDp7TOnA-1
X-Mimecast-MFC-AGG-ID: APlfq7fZPr-9cgSDp7TOnA_1747039362
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf446681cso22685355e9.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 01:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039361; x=1747644161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6ohPqMOJcmTNEQKajOFANKaCxzi/ZzXJ8BO28MUwXQ=;
        b=TIQ2ru1iMc4VeHlAaCW90/MgpvrY8G+zlwowmaTZr/hdl5GBAXKHUNYm+yp8j3mJB3
         Sst4wI3wEv14JdbmqoDGYPY4dnuTHAcZ+J0rBaZLMYOaL7qrNH8iQ7jx0sfQiiRtBFr9
         VTeKeW1mPdBuY0UUKITQWbkcm6/JAs3XrBHQ54jEh+fImI4kqQLNEE3yAtsxwxLS24B0
         ld9vLiX1StB9XBwCy+tycsyNEuGepYEljc0jnnlsCnjVhp/ULybCqGEl3HtAZ/IiZrc5
         WLme7oe98L/7OfXh9Fe+IIHLjipUrC1InzV4nrNuOQoOClSOmNsOK5Iq7r2Zzi7L4Y3m
         zJsQ==
X-Gm-Message-State: AOJu0Yz2F8JcoMeD7AM1nocgr7lWjydNAZY/vr7nrgOdeocu7h25DJ1f
	ph1oAkMOp1NzcrjfsLd8iSH+f57GWqPVicqXfNYysa2bnVAoKm8aTX7cnVN6D/pupd+UNQ9DFnA
	pyvh8xj3dJ7zLPhEM1zC0STeYhbty7zMxseZcVAXjqp7vfZKgK1aS1/h9nQ==
X-Gm-Gg: ASbGncsO5Doybaj69vw/rTr2g+tGzhLUV3qyuIvyPVjN07izLbL61iWYAGbUgxcSjLz
	R+E2ick1RuG1B7vKu+4w44U81Mms7QRw23KKr5Ul1Nr7qfRlLMkrhCoyP7POt65UXd9wpSxpiqx
	7WjMwewfd+l7Tz32Vs/P2Djg/DPTYycNLJW+qrfEAC3MlTb78PaDRcPJ48nkJ4gqOIq8dKbBgUx
	eDbc54PtLV62aLmdJxzvUKu3Jr+PaxA3i5jQ5MNEM/qp1FtOmlamrC96dWTOOnQsj4OMWxeR4Gz
	PIXLkQ==
X-Received: by 2002:a05:600c:6612:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-442d6d44830mr105920975e9.13.1747039361499;
        Mon, 12 May 2025 01:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrFFICCMjlfgRZPh+HswsHits6mww/NovwFZZRp4J19jWEWy4aqUMXbOv5GZaynkA7NY+h+Q==
X-Received: by 2002:a05:600c:6612:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-442d6d44830mr105920555e9.13.1747039361024;
        Mon, 12 May 2025 01:42:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c2asm118205725e9.1.2025.05.12.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:42:40 -0700 (PDT)
Date: Mon, 12 May 2025 04:42:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, linuxarm@huawei.com,
	fan.ni@samsung.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>,
	Vinayak Holikatti <vinayak.kh@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ajay Joshi <ajay.opensrc@micron.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250512043011-mutt-send-email-mst@kernel.org>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
 <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MOAaAXAgR6CllglFSzw5HaZ9LtAcsS2jIoy8o5e4BoA_1747039362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
> From: Arpit Kumar <arpit1.kumar@samsung.com>
> 
> CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> It provides log capabilities supported by specified log.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
>  include/hw/cxl/cxl_mailbox.h |  5 ++++
>  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed6cd50c67..87a376c982 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -133,6 +133,18 @@ typedef enum {
>      CXL_MBOX_MAX = 0x20
>  } CXLRetCode;
>  
> +/* types of logs */
> +typedef enum {
> +    CXL_LOG_COMMAND_EFFECT,
> +    CXL_LOG_VENDOR_DEBUG,
> +    CXL_LOG_COMPONENT_STATE_DUMP,
> +    CXL_LOG_ERROR_CHECK_SCRUB,
> +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> +    MAX_LOG_TYPE
> +} CXLLogType;
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
>  
> +typedef struct CXLLogCapabilities {
> +    uint32_t param_flags;
> +    QemuUUID uuid;
> +} CXLLogCapabilities;
> +
>  typedef struct CXLCCI {
>      struct cxl_cmd cxl_cmd_set[256][256];
>      struct cel_log {
> @@ -171,6 +188,9 @@ typedef struct CXLCCI {
>      } cel_log[1 << 16];
>      size_t cel_size;
>  
> +    /* get log capabilities */
> +    const CXLLogCapabilities *supported_log_cap;
> +
>      /* background command handling (times in ms) */
>      struct {
>          uint16_t opcode;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..8e1c7c5f15 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -16,4 +16,9 @@
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>  
> +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> +
>  #endif
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 299f232f26..f35fc4f112 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,7 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
> +{
> +    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
> +        if (qemu_uuid_is_equal(uuid,
> +            &cci->supported_log_cap[i].uuid)) {
> +                return &cci->supported_log_cap[i];
> +        }
> +    }
> +    return NULL;
> +}
> +
> +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
> +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    const CXLLogCapabilities *cap;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
> +
> +    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
> +
> +    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
> +    if (!cap) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
> +    memcpy(get_log_capabilities_out, &cap->param_flags,
> +           sizeof(cap->param_flags));
> +    *len_out = sizeof(*get_log_capabilities_out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
> +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>      }
>  }
>  
> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
> +};
> +


causes ci build failures:

https://gitlab.com/mstredhat/qemu/-/jobs/9999980051

../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not constant
     [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
                                                            ^~~~~~~~
../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for ‘cxl_get_log_cap[0].uuid’)


Fixed it up like this:

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f35fc4f112..13d26e391b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
 }
 
 /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
-static const QemuUUID cel_uuid = {
-    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
+#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
                  0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
+static const QemuUUID cel_uuid = {
+    .data = CEL_UUID
 };
 
 /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
@@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
 }
 
 static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
-    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
+    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = CEL_UUID },
 };
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)


>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  {
>      cci->payload_max = payload_max;
>      cxl_rebuild_cel(cci);
> +    cci->supported_log_cap = cxl_get_log_cap;
>  
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
> -- 
> 2.43.0

