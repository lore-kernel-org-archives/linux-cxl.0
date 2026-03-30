Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D23C6A2B;
	Mon, 30 Mar 2026 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871042; cv=none; b=FEeoKltlBXyiEAOz+EDBqaOTLd0gs9XBHpYohDTWO0d6SzoXwJ3FB9OKaonQ2h9VRe50vxY3Z+aya8hw8LPnsdeTsuEJ/8fAzhGjL4OE9ZwAUq5q/9jRtlS9ti+IibU/qKqEb612YgH+Xve8HnJtuMnpiGeUYzlmtalJDss4hQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871042; c=relaxed/simple;
	bh=RD1KljObGKXSYd8UJgOJGm/wNIY/qYdC7yIDBV4Nl7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSasSjxLFiUQmU/P0k2kLUodXna2pTjh+j6cIcayE0tyHieFqIhvPsozCvKDIoE2wYXUhvORQXcg0KkTWXcsZI/WpKSWgWzewPkEPBk3f04/bWcYXNFaoethj+VC+AJBuXJl6h448Be7sWt12k2UfnOylZvyqVx+wqtG+G7tRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFu15vSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFu15vSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF1CC4CEF7;
	Mon, 30 Mar 2026 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871041;
	bh=RD1KljObGKXSYd8UJgOJGm/wNIY/qYdC7yIDBV4Nl7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFu15vSVeCbd/xfajB+QwNZhuZioYxLjTI1mGglrm4J0QShB+T3gRGJokeM8hGL+Y
	 bY3Jo6fbu5Iy1BzYcY4Z7m6/qPiSbF/8Zn9Lw3iQ/uiRo57oDs9zp95keg7nZjD69N
	 mOuQGZ2PJp/EUfXNflU1a1imc23H9nphhzIpgkWVuf+YHwr1bLfrYcLWdN/MUqeuWk
	 X/9AKvtbTl4xba8p6NUVYDLWiA/jmTu5OO+0/xJMCuc6Ob9cUi3RBLNZ7QWJtyils7
	 UiBPaTP0wYTxvzxrFAjJ/8pWybyXWBMUsQMAugGYB6L7h3vRNp/bYWv/H93AYBOwYZ
	 ruOTNJDd2kKVg==
Message-ID: <837fe882-0d42-47eb-9234-9d5787148650@kernel.org>
Date: Mon, 30 Mar 2026 13:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>, Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org,
 vbabka@suse.cz, harry.yoo@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <2356614e-d9b8-4639-8e2a-96c5e4eaef61@kernel.org>
 <20260327163554.42487-1-joshua.hahnjy@gmail.com>
 <onaszvpegcqt2y3domgplkne5wrpk7iibgj3mybx4wvckqwe5f@qrnlhiksef4b>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <onaszvpegcqt2y3domgplkne5wrpk7iibgj3mybx4wvckqwe5f@qrnlhiksef4b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/26 05:03, Hao Li wrote:
> On Fri, Mar 27, 2026 at 09:35:54AM -0700, Joshua Hahn wrote:
>> On Fri, 27 Mar 2026 15:44:18 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>> 
>> > >> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
>> > >> offline_pages(). Set the bit when a node that currently lacks normal
>> > >> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
>> > >> offlining removes the last present pages from zones <= ZONE_NORMAL.
>> > >> 
>> > >> This restores the intended semantics without bringing back the old
>> > >> status_change_nid_normal notifier plumbing which was removed in
>> > >> 8d2882a8edb8.
>> > 
>> > But commit 8d2882a8edb8 didn't introduce the current state, or did it?
>> 
>> I don't mean to speak on Hao's behalf, but as far as I can tell I think this
>> would have been the commit to introduce the state, since 
>> node_states_check_changes_online would set status_change_nid_normal to nid,
>> then nodes_states_set_node would come around and set it to N_NORMAL_MEMORY.
>> Maybe I'm missing something? :0
> 
> Thanks for this analysis. I was thinking the same. N_NORMAL_MEMORY is no longer
> updated after this commit.

You're right. Initially I found a much older commit that seemed to remove
updating N_NORMAL_MEMORY shortly after it was introduced. But seems it was
reintroduced later and indeed 8d2882a8edb8 removed it again. Partially my
fault as I reviewed that commit and was blind to that aspect - that it's not
just removing an unused status_change_nid_normal. Thanks for figuring that out!

>> 
>> Thanks for the reply, Vlastimil. I hope you have a great day : -)
>> Joshua
> 

