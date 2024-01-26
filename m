Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080B5A784
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311133; cv=pass; b=M/bIO+BBZRO4rydiv9FADlrbsdYtr+cz62VHjmod4afdWivTk24JateBrZohAnuJzHLeLE6LCvqrN/Kujw3iM0YD5BWDEjnhp1jeTU5K9a4Pt4sqyoLFJy+ELqWUuy+klLgqAyJpkA/J5jkq/kLvq3vu7Zukz7QPREzYKTtrf4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311133; c=relaxed/simple;
	bh=Fd0He+WvjtJ/RN49RTIfBBJtpm1Ma3rzu9sp/SAd4fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1ey8hE9q9D0WJ4w3hHa94y21iU+5uZGxksDhMNzl1fGaD7pLgovooDei4+WbrovR+9eO2E+lo3j956HZxwjQhh6PesjNinm+A+60vbX58FqvBrC7vjD4CMdbPybktV39hGb64l36Chfm5HnKXl7zuhOkEk/A1tDHMRKGBtW4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=m2q+I1Uy; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="m2q+I1Uy"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 74C91903241;
	Fri, 26 Jan 2024 16:57:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0560690311E;
	Fri, 26 Jan 2024 16:57:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1706288231; a=rsa-sha256;
	cv=none;
	b=MSaMMPhlLj102N7mhZp665UsBCKd66H4zWtvwDWNvXRNabpWEC+hKdoAulP8n5PFGPL2Ut
	m6fZnszFomERC70pzQxYIzrUrU1Gkk2pTzE60q+MRVjLLFdbzdVsjS2yF12EaywBi9s4QE
	ccvOIBJnOxs38FMjmq1gNWD8FFcpeDq7UNEObaD7BESZwlbTOIs//sRq3KJeLbO9YkheEt
	yFbK5nZiOQjPIcft46IUeMy7k7B/ywSpPYB2qYPiIEKGbbWG8b9shhc0xh1LyJT3pa/E8o
	9chzvgSKtbpPMH0rDwqpRCFuvV9T06cGF6W/DL+OQQlp68pJ1j/2oNViOt+siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1706288231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0pJM9jYZ0x1QO/XiCYwEUVZ4Z5IW+95tGi+Ke5NjIhM=;
	b=aWHbWxkL08EgCsYRMN3Eqnfdlk7GKP97GO2kD/006E1dfKx8gpyHSGubQQ115+25qfFmI7
	biS+xjfKCZ5EqFkKU+5jhW2bktFMK3q+arp4rBbd1Mrj44513dMhqO4wJQm9GiTSJsTDkV
	OVCPImC5AJBKDVWodXjdSU7vAIiD4aWdX0OyDXGsdasqXokVEPY9WdW5XtRoeUMPaRBNJ0
	foFljBKJnsQ4EE+gjXAbKuxSWpO3xUpDqovKqXcfqZMk0eA1aDprwvnaTssz/DJ3x2ycie
	Tz60reuMYlmfeZIUNbTpQ6Nv7fncDjcI1++KWgIcATa3Jo5/MAe5UimXzZ9nyw==
ARC-Authentication-Results: i=1;
	rspamd-6fdd97fffb-mscl8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Name: 4c0df43403bcb34b_1706288231353_4092635931
X-MC-Loop-Signature: 1706288231353:616841238
X-MC-Ingress-Time: 1706288231353
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.135.40 (trex/6.9.2);
	Fri, 26 Jan 2024 16:57:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4TM3lB3GsvzBB;
	Fri, 26 Jan 2024 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1706288230;
	bh=0pJM9jYZ0x1QO/XiCYwEUVZ4Z5IW+95tGi+Ke5NjIhM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=m2q+I1Uycjer72dp5sVFdnWOLBHtuExMXR7c8V5WVLGHOJl+2UyRlQaZn4Zx03+hX
	 sWy1mSiban7DkiSOjsRlvSuOatoJn9E68pAr77Ace9nbfmeujzIOuk7zhux61QlbKM
	 RRkHmx9uCLQvJ/+VMWUTo10JxRIwfUX8n5x6F8lpPLCNaN8pAaSWqCSw1/ubgbIFdP
	 uSpxzphtDcMrlG7cS7Nf5B9TI7suio0yFSB656C7SYJH8yFFM4EBr0hZ8ZNvP1K8SD
	 QJSVSgqXGyMqP2hcuPIqMY4qz/2FaoNRfToeC0QU7I1nCPXP7sCqUjJgmCakjFIkvh
	 VyPS0+2llggYQ==
Date: Fri, 26 Jan 2024 08:57:07 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: vishal.l.verma@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com, 
	mounika.k@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: Re: [PATCH 2/2] hw/cxl: Add Activate FW support
Message-ID: <b6qqnuyzxtk7lpbf2duxcmi477wdikrtbnwhzxvg2suhgsofez@gccsm2ee3neu>
References: <20240109070436.21253-1-dave@stgolabs.net>
 <20240109070436.21253-3-dave@stgolabs.net>
 <20240126155407.00005335@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240126155407.00005335@Huawei.com>
User-Agent: NeoMutt/20231221

On Fri, 26 Jan 2024, Jonathan Cameron wrote:

>On Mon,  8 Jan 2024 23:04:36 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Per the latest 3.1 spec for supporting firmware activation.
>> Online mode is supported by the hw but never incurs in a
>> background operation.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr.
>
>One question inline.

Thanks for having a look.

>J
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 57 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 0295ea8b29aa..7878604595dd 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -61,6 +61,7 @@ enum {
>>      FIRMWARE_UPDATE = 0x02,
>>          #define GET_INFO      0x0
>>          #define TRANSFER      0x1
>> +        #define ACTIVATE      0x2
>>      TIMESTAMP   = 0x03,
>>          #define GET           0x0
>>          #define SET           0x1
>> @@ -852,7 +853,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>>      fw_info->slots_supported = CXL_FW_SLOTS;
>>      fw_info->slot_info = (cci->fw.active_slot & 0x7) |
>>              ((cci->fw.staged_slot & 0x7) << 3);
>> -    fw_info->caps = 0;
>> +    fw_info->caps = BIT(0);
>>
>>      if (cci->fw.slot[0]) {
>>          pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
>> @@ -961,6 +962,55 @@ static void __do_firmware_xfer(CXLCCI *cci)
>>      cci->fw.transfering = false;
>>  }
>>
>> +/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
>> +static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
>> +                                               uint8_t *payload_in,
>> +                                               size_t len,
>> +                                               uint8_t *payload_out,
>> +                                               size_t *len_out,
>> +                                               CXLCCI *cci)
>> +{
>> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
>> +    struct {
>> +        uint8_t action;
>> +        uint8_t slot;
>> +    } QEMU_PACKED *fw_activate;
>> +
>> +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
>> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
>
>Why?  Mind you I'm not sure why the get firmware info command is checking
>the same. This will probably go upstream post DCD so if we do need
>this check it needs to add an option for a DCD only device.

Will remove.

>
>> +        return CXL_MBOX_INTERNAL_ERROR;
>> +    }
>> +
>> +    fw_activate = (void *)payload_in;
>> +
>> +    if (fw_activate->slot == 0 ||
>> +        fw_activate->slot == cci->fw.active_slot ||
>> +        fw_activate->slot > CXL_FW_SLOTS) {
>> +        return CXL_MBOX_FW_INVALID_SLOT;
>> +    }
>> +
>> +    /*
>> +     * Check that an actual fw package is there, otherwise
>> +     * just become a nop.
>> +    */
>Odd indent.
>
>Also, Spec reference would be good for this as I can't
>immediately see anything beyond the statement about failing
>to activate.  I assume that path applies if there is a firmware there
>but loading it fails for some reason and we roll back and for
>that there is an error code.

This case just occurred to me while writing the patch, I could not
find an answer in the spec.

>
>So I think this should return an error but not obvious if Invalid Input
>or Invalid Slot.

Fine with me, I'll go with Invalid Slot.

Thanks,
Davidlohr
