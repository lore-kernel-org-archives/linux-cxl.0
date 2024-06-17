Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45817F397
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653047; cv=pass; b=jn9Ls80oJnXH+uiFVklht/QFXIlz8RbWqBmsVInjLpGrUJFIEUKr0m0F+Xs+xzSYAG702YWynrbPoF+SDWPnvfYdmrllyDDr9iFdZkoOD+tCBmnPTo1Iy5EtSW4fhQ/146KMCAUbraKf7KMZVQux6wIBkcnAm2l3taeh+F3fs2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653047; c=relaxed/simple;
	bh=Ly3qNvwAMxiYn7oXp8K1UQiJcA/yhuO/mJssiN8s3zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmSkwlTXKlZEF98UiNR4WeaSaYc91BVaZUmyvVDUEblPGs6P2Kz/DYb70r/2oqvFdtwtlvq6JoifmpdxpjGj5xTtFK3ozwpXuDibPOYQxQ/cnCXjDyAnt2hWxVcOcXRHIU14RuapDpiahQzcqtAmBBX6LMRBXjxToiDIDMRAgTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=f7rHmjia; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="f7rHmjia"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C15DD505B75;
	Mon, 17 Jun 2024 19:37:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3210F505C75;
	Mon, 17 Jun 2024 19:37:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1718653034; a=rsa-sha256;
	cv=none;
	b=qERyO/pAmQiA0R8ceFhxQVw/5JLINPtNhhmtMdnYkmJnrVAihQPrNEN0MTdbiLCBqSFcm4
	X/tZa6OZGC9WSv5kOsOvp5yi7zNrpMV9HM8Zzbzvy9tovdBhPgDUfEptbrYEAkoHeitCL9
	Z12PUeh38I6b780Qb+CT9DT2bJZtfCQBBOVDoju8un1e3jJeSnnrqX06zUBDcL0/G+DkAW
	iy8bvc6XYOgFag30Gobjd+JRaOcc4OBqFgU13jPruW/7LnhdQBzKT8tYvjvdo2rsbOn2B7
	PDxl5zfGBmKN3GkyCdjHXCFkjYE94i4laEbuLJx1VJjE0mU1LM7heiQ4iM/IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1718653034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=i8YCQafUoGMSlXZXG8oJSQcFhkxTFfDarcJGjdiCwps=;
	b=PDRvpkeMpYPu0VoXVabIxk8vC8EcTo7+QFe553F6RfJ1GjQbqf7yt53vTjd/xY5TmQRMV6
	mEztNy+u8UHdVVgsJJW5l0B9/VGy8fIryfw1SbKPmfQ6FpCJgvtvT/81mtQOMhnYidPI2V
	2RQo2f+h3g+ACBE9fFF+Byha6oWwOdvmUACjIQfNJl8wwNMXpQaay67Bz4TGeB9oq8pHtz
	KGX0XoQe+3mMsYl3JhXfGrd27O8IVZZOe7+SVhggS5LF95KMYcmRsp9oWSeWQiaRyMqdrT
	sKaJ8u3ITdK2p2WqmxGz0D5y+NaunAkLfShxe9OYyug4OmH0vEkrwJgI4mJIqA==
ARC-Authentication-Results: i=1;
	rspamd-79677bdb95-kt8wt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Abortive: 3d1a1e5813c2f222_1718653034711_1573792860
X-MC-Loop-Signature: 1718653034710:761866797
X-MC-Ingress-Time: 1718653034710
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.33.136 (trex/6.9.2);
	Mon, 17 Jun 2024 19:37:14 +0000
Received: from offworld (unknown [172.56.183.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4W30Ws1Thdz9t;
	Mon, 17 Jun 2024 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1718653034;
	bh=i8YCQafUoGMSlXZXG8oJSQcFhkxTFfDarcJGjdiCwps=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=f7rHmjia3Mu86ILqu0qkIyEOOqdKIpG6Pfzlhd1QqmMaq3I0QriczqbjnaqqYtLMF
	 OmHiCUguh6Ebj7U9pyPFCyLHjTC7judqTWYLZ9M36s3vZgH6237Pl9ca0TMkWuWXGL
	 e7SQ0Kbo0hAfrWvaK5rfm+fDkD6v9FeTonvsioBKY3a1afpjPC7bNvR5CVj/JEvebC
	 UZyYNw0ebqseL3GaboMuIEEnEtAI7udlMhgigaPLklFR13gUB77W5i/3+IwKcxU3m/
	 +JhWnI0Vc7Ah2C3acCtxBdG/mH3aVQlO4pORlgNdax3+MabctkctZ6U3/5oQUyFGik
	 IwgnFyCCPrDSg==
Date: Mon, 17 Jun 2024 12:37:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: vishal.l.verma@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com, 
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <o54dzo3ofnyov7hhh2kcktjfsvvu7oxfqyilu5vl4wrdnzl3ma@iy447qho7kit>
References: <20240205172942.13343-1-dave@stgolabs.net>
 <20240422165126.00006567@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240422165126.00006567@Huawei.com>
User-Agent: NeoMutt/20240416

Hi Jonathan,

Just now had some cycles to return to this.

And I was not able to reproduce the overlapping behavior I
mentioned in the kernel support - I guess this might be an
incorrect test I had in place. So sorry for the false alarm,
and for the record, below is the pasted actual byte ranges
sent by the driver for a 52k image.

prev range: 0-0 ... this range: 0-1920
prev range: 0-1920 ... this range: 1920-3840
prev range: 1920-3840 ... this range: 3840-5760
prev range: 3840-5760 ... this range: 5760-7680
prev range: 5760-7680 ... this range: 7680-9600
prev range: 7680-9600 ... this range: 9600-11520
prev range: 9600-11520 ... this range: 11520-13440
prev range: 11520-13440 ... this range: 13440-15360
prev range: 13440-15360 ... this range: 15360-17280
prev range: 15360-17280 ... this range: 17280-19200
prev range: 17280-19200 ... this range: 19200-21120
prev range: 19200-21120 ... this range: 21120-23040
prev range: 21120-23040 ... this range: 23040-24960
prev range: 23040-24960 ... this range: 24960-26880
prev range: 24960-26880 ... this range: 26880-28800
prev range: 26880-28800 ... this range: 28800-30720
prev range: 28800-30720 ... this range: 30720-32640
prev range: 30720-32640 ... this range: 32640-34560
prev range: 32640-34560 ... this range: 34560-36480
prev range: 34560-36480 ... this range: 36480-38400
prev range: 36480-38400 ... this range: 38400-40320
prev range: 38400-40320 ... this range: 40320-42240
prev range: 40320-42240 ... this range: 42240-44160
prev range: 42240-44160 ... this range: 44160-46080
prev range: 44160-46080 ... this range: 46080-48000
prev range: 46080-48000 ... this range: 48000-49920
prev range: 48000-49920 ... this range: 49920-51200

On Mon, 22 Apr 2024, Jonathan Cameron wrote:\n
>On Mon,  5 Feb 2024 09:29:42 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Implement transfer and activate functionality per 3.1 spec for
>> supporting update metadata (no actual buffers). Transfer times
>> are arbitrarily set to ten and two seconds for full and part
>> transfers, respectively.
>>
>> Testing for both a successful part fw package transfer success
>> and abort/cancel cases:
>>
>> // on-going partial xfer
>> {
>>   "firmware":{
>>     "num_slots":2,
>>     "active_slot":1,
>>     "staged_slot":1,
>>     "online_activate_capable":true,
>>     "slot_1_version":"BWFW VERSION 0",
>>     "fw_update_in_progress":true,
>>     "remaining_size":1280
>>   }
>> }
>>
>> // xfer complete
>> {
>>   "firmware":{
>>     "num_slots":2,
>>     "active_slot":1,
>>     "staged_slot":2,
>>     "online_activate_capable":true,
>>     "slot_1_version":"BWFW VERSION 0",
>>     "slot_2_version":"BWFW VERSION 1",
>>     "fw_update_in_progress":false
>>   }
>> }
>>
>> // on-going (new) partial xfer
>> {
>>   "firmware":{
>>     "num_slots":2,
>>     "active_slot":1,
>>     "staged_slot":1,
>>     "online_activate_capable":true,
>>     "slot_1_version":"BWFW VERSION 0",
>>     "fw_update_in_progress":false
>>   }
>> }
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr,
>
>I was going to just pick this up and make the tweaks Fan suggested,
>but there are more issues vs the spec that I think should be resolved
>first.  If you are busy shout and I'll just make the changes and send
>a v3.
>
>Thanks,
>
>Jonathan
>
>> ---
>> Changes from v1:
>>  - robustify part transfer checking (Jonathan)
>>  - implement abort
>>  - increase runtime for full transfer
>>  - no longer prematurely mark the slot
>>  - fold both cmds into a single patch
>>
>>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
>>  include/hw/cxl/cxl_device.h |  16 +++
>>  2 files changed, 228 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 80a80f1ec29b..74054855b1fa 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -60,6 +60,8 @@ enum {
>>          #define SET_INTERRUPT_POLICY   0x3
>>      FIRMWARE_UPDATE = 0x02,
>>          #define GET_INFO      0x0
>> +        #define TRANSFER      0x1
>> +        #define ACTIVATE      0x2
>>      TIMESTAMP   = 0x03,
>>          #define GET           0x0
>>          #define SET           0x1
>> @@ -815,6 +817,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +#define CXL_FW_SLOTS 2
>> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
>> +
>>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>>                                                 uint8_t *payload_in,
>> @@ -846,15 +851,204 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>>      fw_info = (void *)payload_out;
>>      memset(fw_info, 0, sizeof(*fw_info));
>>
>> -    fw_info->slots_supported = 2;
>> -    fw_info->slot_info = BIT(0) | BIT(3);
>> -    fw_info->caps = 0;
>> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
>> +    fw_info->slots_supported = CXL_FW_SLOTS;
>> +    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
>> +            ((cci->fw.staged_slot & 0x7) << 3);
>> +    fw_info->caps = BIT(0);
>
>I'd add a comment on this one for what it is. "Online update supported"
>Given this is trivial I amend the patch on my tree.

Sure.

>
>> +
>> +    if (cci->fw.slot[0]) {
>> +        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
>Hmm. Maybe we should fake something up in the way of an ID that changes as fw's are
>uploaded.  Maybe as simple as not initiating slot[1] until a firmware has bee
>uploaded.  I just want to see this change with an upload.

Sure.

>> +    }
>> +    if (cci->fw.slot[1]) {
>> +        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
>> +    }
>>
>>      *len_out = sizeof(*fw_info);
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
>> +#define CXL_FW_XFER_ALIGNMENT   128
>> +
>> +#define CXL_FW_XFER_ACTION_FULL	    0x0
>> +#define CXL_FW_XFER_ACTION_INIT	    0x1
>> +#define CXL_FW_XFER_ACTION_CONTINUE 0x2
>> +#define CXL_FW_XFER_ACTION_END	    0x3
>> +#define CXL_FW_XFER_ACTION_ABORT    0x4
>> +
>> +static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
>> +                                               uint8_t *payload_in,
>> +                                               size_t len,
>> +                                               uint8_t *payload_out,
>> +                                               size_t *len_out,
>> +                                               CXLCCI *cci)
>> +{
>> +    struct {
>> +        uint8_t action;
>> +        uint8_t slot;
>> +        uint8_t caps;
>
>Dropped caps as per Fan's comment.
>
>> +        uint8_t rsvd1[2];
>> +        uint32_t offset;
>> +        uint8_t rsvd2[0x78];
>> +        uint8_t data[];
>> +    } QEMU_PACKED *fw_transfer = (void *)payload_in;
>> +    size_t offset, length;
>> +
>> +    if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
>> +        /*
>> +         * At this point there aren't any on-going transfers
>> +         * running in the bg - this is serialized before this
>> +         * call altogether. Just mark the state machine and
>> +         * disregard any other input.
>> +         */
>> +        cci->fw.transferring = false;
>> +        return CXL_MBOX_SUCCESS;
>> +    }
>> +
>> +    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
>> +    length = len - sizeof(*fw_transfer);
>> +    if (offset + length > CXL_FW_SIZE) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    if (cci->fw.transferring) {
>> +        if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
>> +            fw_transfer->action == CXL_FW_XFER_ACTION_INIT) {
>> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
>> +        }
>> +        /*
>> +         * Abort partitioned package transfer if over 30 secs
>> +         * between parts. As opposed to the explicit ABORT action,
>> +         * semantically treat this condition as an error - as
>> +         * if a part action were passed without a previous INIT.
>> +         */
>> +        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
>> +            cci->fw.transferring = false;
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +    } else if (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
>> +               fw_transfer->action == CXL_FW_XFER_ACTION_END) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    /* allow back-to-back retransmission */
>> +    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
>> +        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
>> +         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
>> +        /*
>> +         * XXX: Linux is happy to send overlapping chunks,
>> +         * so just verify no gaps.
>> +         */
>
>Does the CXL spec allow overlapping?  I see text about parts being
>in order (with an exception for back to band transfer). So I think
>we need to reject any overlap and make sure Linux doesn't do it!
>
>
>The 3rd example in the imp note implies that overlap definitely isn't
>allowed.

Yep, hence the above comment, which also happens to be wrong. And, per
the examples in the imp notes, it looks like gaps are in fact allowed
(0-100h, 160h-260h is considered valid, for example).

>
>> +        if (offset > cci->fw.prev_offset + cci->fw.prev_len) {

So this really turns into 'offset < ...'

>> +            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
>> +        }
>> +    }
>> +
>> +    switch (fw_transfer->action) {
>> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
>> +    case CXL_FW_XFER_ACTION_END:
>> +        if (fw_transfer->slot == 0 ||
>> +            fw_transfer->slot == cci->fw.active_slot ||
>> +            fw_transfer->slot > CXL_FW_SLOTS) {
>> +            return CXL_MBOX_FW_INVALID_SLOT;
>> +        }
>> +
>> +        /* mark the slot used upon bg completion */
>> +        break;
>> +    case CXL_FW_XFER_ACTION_INIT:
>> +        if (offset != 0) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +
>> +        cci->fw.transferring = true;
>> +        cci->fw.prev_slot = fw_transfer->slot;
>
>Why?  This is only valid for Full and End.

oh it occurred to me that the spec was implying that partial
transfers do want to be the same (Slot=X) regardless of only
caring about the actual value at the End transfer. I wasn't
sure, so took the cautious side.

But if this is not the case, it might be useful to update
the spec and be more explicit.

>
>> +        cci->fw.prev_offset = offset;
>> +        cci->fw.prev_len = length;
>> +        break;
>> +    case CXL_FW_XFER_ACTION_CONTINUE:
>> +        /* forbid slot interleaving */
>
>From 3.1 spec the slot is only specified in the final transfer.

See above.

>
>> +        if (cci->fw.prev_slot != fw_transfer->slot) {
>> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
>> +        }
>> +
>> +        cci->fw.prev_offset = offset;
>> +        cci->fw.prev_len = length;
>> +        break;
>> +    default:
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL) {
>> +        cci->bg.runtime = 10 * 1000UL;
>> +    } else {
>> +        cci->bg.runtime = 2 * 1000UL;
>> +    }
>> +    /* keep relevant context for bg completion */
>> +    cci->fw.curr_action = fw_transfer->action;
>> +    cci->fw.curr_slot = fw_transfer->slot;
>> +    *len_out = 0;
>> +
>> +    return CXL_MBOX_BG_STARTED;
>> +}
>> +
>> +static void __do_firmware_xfer(CXLCCI *cci)
>> +{
>> +    switch (cci->fw.curr_action) {
>> +    case CXL_FW_XFER_ACTION_FULL:
>> +    case CXL_FW_XFER_ACTION_END:
>> +        cci->fw.slot[cci->fw.curr_slot - 1] = true;
>> +        cci->fw.transferring = false;
>> +        break;
>
>return early would be my preference.
>
>> +    case CXL_FW_XFER_ACTION_INIT:
>> +    case CXL_FW_XFER_ACTION_CONTINUE:
>> +        time(&cci->fw.last_partxfer);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>> +/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
>> +static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
>> +                                               uint8_t *payload_in,
>> +                                               size_t len,
>> +                                               uint8_t *payload_out,
>> +                                               size_t *len_out,
>> +                                               CXLCCI *cci)
>> +{
>> +    struct {
>> +        uint8_t action;
>> +        uint8_t slot;
>> +    } QEMU_PACKED *fw_activate = (void *)payload_in;
>> +
>> +    if (fw_activate->slot == 0 ||
>> +        fw_activate->slot == cci->fw.active_slot ||
>
>Whilst I don't see spec text on this case, I can't see a request
>for clarification resulting in an errata for this given it's
>nonsense to do it so software shouldn't care if this is an error
>return or a noop 'sure I'll set the firmware to the firmware I'm
>running - it'll be really quick!'.
>
>> +        fw_activate->slot > CXL_FW_SLOTS) {
>> +        return CXL_MBOX_FW_INVALID_SLOT;
>> +    }
>> +
>> +    /*
>> +     * XXX: Check that an actual fw package is there - spec
>> +     * does not mention this case.
>Obviously and error, so I guess you mean which one?
>Between this an Invalid Input.
>
>Given it's an error case software shouldn't hit anyway another
>one where an errata is unlikely.  Maybe worth asking the question
>however..
>
>> +     */
>> +    if (!cci->fw.slot[fw_activate->slot - 1]) {
>> +        return CXL_MBOX_FW_INVALID_SLOT;
>> +    }
>> +
>> +    switch (fw_activate->action) {
>> +    case 0: /* online */
>> +        cci->fw.active_slot = fw_activate->slot;
>> +        break;
>> +    case 1: /* reset */
>> +        cci->fw.staged_slot = fw_activate->slot;
>> +        break;
>> +    default:
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
>>  static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
>>                                      uint8_t *payload_in,
>> @@ -2160,6 +2354,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>                                        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
>>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>>          cmd_firmware_update_get_info, 0, 0 },
>> +    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
>> +        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
>> +    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
>> +        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
>>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
>>                           8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>> @@ -2275,7 +2473,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>>              h == cmd_media_get_poison_list ||
>>              h == cmd_media_inject_poison ||
>>              h == cmd_media_clear_poison ||
>> -            h == cmd_sanitize_overwrite) {
>> +            h == cmd_sanitize_overwrite ||
>> +            h == cmd_firmware_update_transfer ||
>> +            h == cmd_firmware_update_activate) {
>
>This clashed with an updated fix in my tree to avoid accessing
>fields that don't exist on non type 3 CCIs (Switch-cci etC).
>
>The overall check is currently using state in the type3 device
>structure.  Ultimately we should make this work for switches
>as well but that can be a job for another day.

Yeah, will address separately.

>
>>              return CXL_MBOX_MEDIA_DISABLED;
>>          }
>>      }
>> @@ -2319,6 +2519,9 @@ static void bg_timercb(void *opaque)
>>          cci->bg.complete_pct = 100;
>>          cci->bg.ret_code = ret;
>>          switch (cci->bg.opcode) {
>> +        case 0x0201: /* fw transfer */
>> +            __do_firmware_xfer(cci);
>> +            break;
>>          case 0x4400: /* sanitize */
>>          {
>>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> @@ -2390,6 +2593,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>>      cci->bg.runtime = 0;
>>      cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>>                                   bg_timercb, cci);
>> +
>> +    memset(&cci->fw, 0, sizeof(cci->fw));
>> +    cci->fw.active_slot = cci->fw.staged_slot = 1;
>
>Why not set staged_slot to 0 on init?
>
>"If 0, no FW is currently staged for activation."

I prefer following the spec convention directly here.

>
>> +    cci->fw.slot[cci->fw.active_slot - 1] = true;
>>  }
>>
>>  static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index d38391b26f0e..8c17ba9d2131 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -203,7 +203,22 @@ typedef struct CXLCCI {
>>          uint64_t runtime;
>>          QEMUTimer *timer;
>>      } bg;
>> +
>> +    /* firmware update */
>> +    struct {
>> +        uint8_t active_slot;
>> +        uint8_t staged_slot;
>> +        bool slot[4];
>> +        uint8_t curr_action;
>> +        uint8_t curr_slot;
>> +        /* handle partial transfers */
>> +        bool transferring;
>> +        uint8_t prev_slot;
>> +        size_t prev_offset;
>> +        size_t prev_len;
>> +        time_t last_partxfer;
>> +    } fw;
>> +
>>      size_t payload_max;
>>      /* Pointer to device hosting the CCI */
>>      DeviceState *d;
>> --
>> 2.43.0
